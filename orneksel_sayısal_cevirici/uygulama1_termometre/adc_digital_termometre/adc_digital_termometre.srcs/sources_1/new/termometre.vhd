----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2018 02:31:08 PM
-- Design Name: 
-- Module Name: termometre - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity termometre is
generic(
    init_d  : integer  :=  4000000;  --40 ms gecikme
    com_dl  : integer  :=  200000;   --2  ms gecikme
    com_ds  : integer  :=  5000    --50 us gecikme
);
port(     
    ra0					:inout std_logic;--adcnin açilip kapanmasini kontrol eder.
    ortam_sicakligi	    : inout unsigned (7 downto 0);
    
    USER_CLK        	: in      std_logic;
                
    LCD_FPGA_DB			: inout   unsigned(3 downto 0);
    LCD_FPGA_E			: out	  std_logic;
    LCD_FPGA_RS			: out	  std_logic;
    LCD_FPGA_RW			: out	  std_logic
);
			
end termometre;

architecture Behavioral of termometre is

signal counter_for_adc: unsigned(3 downto 0);

type tip_mesaj is array (0 to 43) of unsigned(7 downto 0);
signal mesaj : tip_mesaj:=(others=>"00000000");

signal  lcd  :  unsigned(6 downto 0):="1111111";

signal clock_5hz:std_logic;
 
begin
 
 
LCD_FPGA_DB	<=	lcd(3 downto 0);
LCD_FPGA_E	<=	lcd(6);
LCD_FPGA_RS	<=	lcd(5);
LCD_FPGA_RW	<=	lcd(4);



process(USER_CLK)
variable counter:integer range 0 to 10000000:=0;
begin
if rising_edge(USER_CLK) then
	if counter=10000000 then
		counter:=0;
		clock_5hz<=not clock_5hz;
	else	
		counter:=counter+1;
	end if;	
end if;	

end process;

process(clock_5hz,counter_for_adc)
begin
--baslat komutu geldiginde adc'yi açmak için counter saymaya baslar.

if rising_edge(clock_5hz) then
		counter_for_adc<=counter_for_adc+1;


--4bitlik counter'in 0001 aninda adc açilir.geri kalan 15 birim zamanda ise kapali kalir.

case(counter_for_adc) is
	when"0001"	=>	ra0<='0';
	when others	=> ra0<='1';
end case;

end if;
--
end process;

 
process(USER_CLK,ra0,ortam_sicakligi)

variable rb3: unsigned(7 downto 0);
variable rb5: unsigned(7 downto 0);                  
 

variable	adim	:	integer range 0 to 23		:=	0;
variable	sayac	:	integer range 0 to 5000000	:=	0;


variable	i	:	integer range 0 to 43		:=	0;
  
  
  
  begin
 


		if ra0='0' then
			rb5:=ortam_sicakligi;
		end if;


--binary to bcd converter.rb3 bcdye çevrilmis seklidir.

if rb5<"00001010" then
	rb3:=rb5;
elsif rb5<"00010100" then
	rb3:=rb5+6;
elsif rb5<"00011110" then
	RB3:=rb5+12;
elsif rb5<"00101000"then
	rb3:=rb5+18;
elsif rb5<"00110010"then
	rb3:=rb5+24;
elsif rb5<"00111100"then
	rb3:=rb5+30;
elsif rb5<"01000110"then
	rb3:=rb5+36;
elsif rb5<"01010000"then
	rb3:=rb5+42;
elsif rb5<"01011010"then
	rb3:=rb5+48;
elsif rb5<"01100100"then
	rb3:=rb5+54;
else 
	rb3:="01100011";
end if;



--YAZDIRILACAK VERI ASAGIDA TANIMLANIR----
  
  
 mesaj  (0 TO 15) <=((X"4f"),(X"52"),(X"54"),(X"41"),(X"4d"),(X"10"),(X"53"),(X"49"),(X"43"),(X"41"),(X"4b"),(X"4c"),(X"49"),(X"47"),(X"49"),(X"10"));
------------------------O-------R-------T-------A--------M---(     )----S-------I-------C-------A-------K--------L-------I-------G-------I-----(  )--

 mesaj  (40 TO 43) <= (("0011"&rb3(7 downto 4)),("0011"&rb3(3 downto 0)), ("11101111"),("01000011")); 
  
  
--------------------------------------------
  
  
----LCDye bastirma kismi----
  
    if(rising_edge(USER_CLK))	then
			sayac:=sayac+1;
		 case	adim	is
---------------Acilis Gecikmesi, 40 ms -----------------------------
		when	0	=>	if (sayac=init_d)	then
						sayac	:=	0;
						adim	:=	1;
					end if;
---------------Acilis Ayarlari, 2x16 biciminde calis----------------
		when	1	=>	lcd <= "1000010";
					if (sayac=com_ds/20) then
						sayac	:=	0;
						adim	:=	2;
					end if;
		when	2	=>	lcd <= "0000010";
					if (sayac=com_ds/20) then
						adim	:=	3;
					end if;
		when	3	=>	lcd <= "1001110";
					if (sayac=com_ds/10) then
						adim	:=	4;
					end if;
		when	4	=>	lcd <= "0001110";
					if (sayac=3*com_ds/20) then
						adim	:=	5;
					end if;
		when	5	=>	lcd <= "1001000";
					if (sayac=com_ds/5) then
						adim	:=	6;
					end if;
		when	6	=>	lcd <= "0000010";
					if (sayac=com_ds) then
						adim	:=	7;
						sayac	:=	0;
					end if;
---------------Ekrani Acma, Imlec ayarlari, Yanip/sonme---------------
		when	7	=>	lcd <= "1000000";
					if (sayac=com_ds/20) then
						adim	:=	8;
					end if;
		when	8	=>	lcd <= "0000000";
					if (sayac=com_ds/10) then
						adim	:=	9;
					end if;
		when	9	=>	lcd <= "1001100";
					if (sayac=3*com_ds/20) then
						adim	:=	10;
					end if;
		when	10	=>	lcd <= "0001100";
					if (sayac=com_ds) then
						adim	:=	11;
						sayac	:=	0;
					end if;
---------------Ekrani Temizle, Baslangic Adresine Git-----------------
		when	11	=>	lcd <= "1000000";
					if (sayac=com_dl/800) then
						adim	:=	12;
					end if;
		when	12	=>	lcd <= "0000000";
					if (sayac=com_ds/400) then
						adim	:=	13;
					end if;
		when	13	=>	lcd <= "1000001";
					if (sayac=3*com_dl/800) then
						adim	:=	14;
					end if;
		when	14	=>	lcd <= "0000001";
					if (sayac=com_dl) then
						adim	:=	15;
						sayac	:=	0;
					end if;
---------------Adresleme Ayarlari Adres Arttirici---------------------
		when	15	=>	lcd <= "1000000";
					if (sayac=com_ds/20) then
						adim	:=	16;
						end if;
		when	16	=>	lcd <= "0000000";
					if (sayac=com_ds/10) then
						adim	:=	17;
					end if;
		when	17	=>	lcd <= "1000110";
					if (sayac=3*com_ds/20) then
						adim	:=	18;
					end if;
		when	18	=>	lcd <= "0000110";
					if (sayac=com_ds) then
						adim	:=	19;
						sayac	:=	0;
					end if;
---------------Ekrana Karakter Basma Islemi(ORTAM SICAKLIGI YAZDIRMA)--------------------------
		when	19	=>	lcd <= "110"&mesaj(i)(7 downto 4);
					if (sayac=com_ds/20) then
						adim	:=	20;
					end if;
		when	20	=>	lcd <= "010"&mesaj(i)(7 downto 4);
					if (sayac=com_ds/10) then
						adim	:=	21;
					end if;
		when	21	=>	lcd <= "110"&mesaj(i)(3 downto 0);
					if (sayac=3*com_ds/20) then
						adim	:=	22;
					end if;
		when	22	=>	lcd <= "010"&mesaj(i)(3 downto 0);
					if (sayac=com_ds) then
						adim	:=	23;
				
					end if;	
					
		when	23	=>		if (i<43) then
						i:=i+1;
						adim	:=	19;
						sayac:=0;
						
						elsif i=43  then
							
							if ra0='0' then
								i:=0;
								adim:=11; 
								sayac:=0;
							end if;
						else 
							i:=43;
						end if;
   
		end case; 
end if;


end process;
end Behavioral;