----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/09/2018 08:52:04 PM
-- Design Name: 
-- Module Name: voltmetre - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity voltmetre is
generic(
		init_d  : integer  :=  4000000;  --40 ms gecikme
		com_dl  : integer  :=  200000;   --2  ms gecikme
	   com_ds  : integer  :=  5000);    --50 us gecikme
		
		
	port(     
	ra0					:inout std_logic;--adcnin açilip kapanmasini kontrol eder.
	adc_cikis_degeri 	: inout unsigned (7 downto 0);
	
	USER_CLK       	: in      std_logic;
                
	LCD_FPGA_DB	 		: inout   unsigned(3 downto 0);
   LCD_FPGA_E	   	: out	  std_logic;
   LCD_FPGA_RS			: out	  std_logic;
	LCD_FPGA_RW			: out	  std_logic
	);
end voltmetre;

architecture Behavioral of voltmetre is
signal counter_for_adc: unsigned(3 downto 0);

type tip_mesaj is array (0 to 8) of unsigned(7 downto 0);
signal mesaj : tip_mesaj:=(others=>"00000000");

signal  lcd  :  unsigned(6 downto 0):="1111111";

signal clock_50hz:std_logic;
begin

LCD_FPGA_DB	<=	lcd(3 downto 0);
LCD_FPGA_E	<=	lcd(6);
LCD_FPGA_RS	<=	lcd(5);
LCD_FPGA_RW	<=	lcd(4);

process(USER_CLK)
variable counter:integer range 0 to 500000:=0;
begin
if rising_edge(USER_CLK) then
	if counter=500000 then
		counter:=0;
		clock_50hz<=not clock_50hz;
	else	
		counter:=counter+1;
	end if;	
end if;	
end process;


process(clock_50hz,counter_for_adc)
begin
--baslat komutu geldiginde adc'yi açmak için counter saymaya baslar.

if rising_edge(clock_50hz) then
		counter_for_adc<=counter_for_adc+1;

--4bitlik counter'in 0001 aninda adc açilir.geri kalan 15 birim zamanda ise kapali kalir.

case(counter_for_adc) is
	when"0001"	=>	ra0<='0';
	when others	=> ra0<='1';
end case;
end if;
--
end process;
 
process(USER_CLK,ra0,adc_cikis_degeri)

variable	adim	:	integer range 0 to 23		:=	0;
variable	sayac	:	integer range 0 to 5000000	:=	0;

variable	i	:	integer range 0 to 8	:=	0;

variable alinan_data: unsigned (7 downto 0):="00000000"; 

Variable integer_value_of_cikis_data: integer range 0 to 500;

variable integer_value_of_alinan_data: integer  range 0 to 500;
variable c:integer range 0 to 500;
  
variable cikis_data_binary: unsigned (7 downto 0);
variable rb3: unsigned (11 downto 0);
variable rb5: unsigned (11 downto 0);

  begin
  
 



		if ra0='0' then
			alinan_data:=adc_cikis_degeri;
		end if;

	
integer_value_of_alinan_data:=to_integer(alinan_data);
integer_value_of_cikis_data:=((integer_value_of_alinan_data*460)/256);


rb5:=to_unsigned(integer_value_of_cikis_data,12);





-----bcd converter-----

if rb5<"000000001010" then
rb3:=rb5;

elsif rb5<"000000010100" then
rb3:=rb5+6;


elsif rb5<"000000011110" then
RB3:=rb5+12;

elsif rb5<"000000101000"then
rb3:=rb5+18;

elsif rb5<"000000110010"then--50
rb3:=rb5+24;


elsif rb5<"000000111100" then
rb3:=rb5+30;

elsif rb5<"000001000110" then
rb3:=rb5+36;


elsif rb5<"000001010000" then
RB3:=rb5+42;

elsif rb5<"000001011010"then
rb3:=rb5+48;

elsif rb5<"000001100100"then--100
rb3:=rb5+54;


elsif rb5<"000001101110" then--110
rb3:=rb5+156;

elsif rb5<"000001111000" then
rb3:=rb5+162;


elsif rb5<"000010000010" then
RB3:=rb5+168;

elsif rb5<"000010001100"then
rb3:=rb5+174;

elsif rb5<"000010010110"then--150
rb3:=rb5+180;


elsif rb5<"000010100000" then
rb3:=rb5+186;

elsif rb5<"000010100110" then
rb3:=rb5+192;


elsif rb5<"000010110100" then--180
RB3:=rb5+198;

elsif rb5<"000010111110"then
rb3:=rb5+204;

elsif rb5<"000011001000"then--200
rb3:=rb5+210;


elsif rb5<"000011010010" then--210
rb3:=rb5+312;

elsif rb5<"000011011100" then
rb3:=rb5+318;


elsif rb5<"000011100110" then
RB3:=rb5+324;

elsif rb5<"000011110000"then
rb3:=rb5+330;

elsif rb5<"000011111010"then--250
rb3:=rb5+336;


elsif rb5<"0000100000100" then--260
rb3:=rb5+342;

elsif rb5<"000100001110" then
rb3:=rb5+348;


elsif rb5<"000100011000" then--280
RB3:=rb5+354;

elsif rb5<"000100100010"then
rb3:=rb5+360;

elsif rb5<"000100101100"then--300
rb3:=rb5+366;

elsif rb5<"000100110110" then--310
rb3:=rb5+468;

elsif rb5<"000101000000" then--320
rb3:=rb5+474;


elsif rb5<"000101001010" then--330
RB3:=rb5+480;

elsif rb5<"000101010100"then--340
rb3:=rb5+486;

elsif rb5<"000101011110"then--350
rb3:=rb5+492;


elsif rb5<"000101101000" then--360
rb3:=rb5+498;

elsif rb5<"000101110010" then--370
rb3:=rb5+504;


elsif rb5<"000101111100" then--380
RB3:=rb5+510;

elsif rb5<"000110000110"then--390
rb3:=rb5+516;

elsif rb5<"000110010100"then--400
rb3:=rb5+522;


elsif rb5<"000110011010" then--410
rb3:=rb5+624;

elsif rb5<"000110100100" then--420
rb3:=rb5+630;


elsif rb5<"000110101110" then--430
RB3:=rb5+636;

elsif rb5<"000110111000"then--440
rb3:=rb5+642;

elsif rb5<"000111000010"then--450
rb3:=rb5+648;


elsif rb5<"000111001100" then--460
rb3:=rb5+654;

elsif rb5<"000111010110" then--470
rb3:=rb5+660;


elsif rb5<"000111100000" then--480
RB3:=rb5+666;

elsif rb5<"000111101010"then--490
rb3:=rb5+672;

elsif rb5<"000111110100"then--500
rb3:=rb5+678;

else
RB3:="010100000000";

end if;
-----



--YAZDIRILACAK VERI ASAGIDA TANIMLANIR----
  
  
mesaj (0 to 8)<= (("0011"&rb3(11 downto 8)),(X"2E"),("0011"&rb3(7 downto 4)),("0011"&rb3(3 downto 0)),(X"10"),(X"56"),(X"4f"),(X"4c"),(X"54"));                      
                                                                                                        ---------V-------O-------L-------T-----  

  
----LCD kontrol kismi----
  
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
					

		when	23	=>		if (i<8) then
								i:=i+1;
								adim	:=	19;
								sayac:=0;
						
							elsif i=8  then
							
								if ra0='0' then
									i:=0;
									adim:=11; 
									sayac:=0;
								end if;

							else 
								i:=8;
						
							end if;

		end case; 
end if;


end process;
end Behavioral;
