----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2018 01:40:06 PM
-- Design Name: 
-- Module Name: lcd - Behavioral
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

entity lcd is
generic(
    init_d  : integer  :=  4000000;  --40 ms gecikme
    com_dl  : integer  :=  200000;   --2  ms gecikme
    com_ds  : integer  :=  5000);    --50 us gecikme
    
    
port(
    USER_CLK        : in      std_logic;
    
    LCD_DB	: inout   unsigned(3 downto 0);
    
    LCD_E	: out	  std_logic;
    LCD_RS	: out	  std_logic;
    LCD_RW	: out	  std_logic);
end lcd;

architecture Behavioral of lcd is




type tip_mesaj is array (0 to 7) of unsigned(7 downto 0);
 
type tip_mesaj1 is array (0 to 11) of unsigned(7 downto 0);

constant mesaj : tip_mesaj :=(
(X"0F"),(X"10"),(X"10"),(X"0E"),(X"01"),(X"01"),(X"1E"),(X"04")); ---cgrame yazdirilacak karakter tanimlaniyor.her eleman 5*8 lik matrisin bir satirini temsil eder.1'ler yanar.msb 3 bit önemsiz.
constant mesaj_ekrana : tip_mesaj1 :=(
(X"42"),(X"45"),(X"54"),(X"69"), (X"10"),   (X"42"),(X"69"),(X"4C"),(X"69"),(X"00"),(X"69"),(X"4D"));
 --B-------E-------T------i----  (bosluk)-----B--------i------L--------i-------Þ-------i-------M                    
 
                              
signal  lcd  :  unsigned(6 downto 0):="1111111";
 
begin
 
LCD_DB	<=	lcd(3 downto 0);
LCD_E	<=	lcd(6);
LCD_RS	<=	lcd(5);
LCD_RW	<=	lcd(4);
 
process(USER_CLK)


variable	adim	:	integer range 0 to 36		:=	0;
variable	sayac	:	integer range 0 to 5000000	:=	0;
variable	i	:	integer range 0 to 11	:=	0;


  begin
  
  
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
		when	9	=>	lcd <= "1001111";
					if (sayac=3*com_ds/20) then
						adim	:=	10;
					end if;
		when	10	=>	lcd <= "0001111";
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
					if (sayac=com_dl/400) then
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
					
---------------cgram adresini set ediyor---------------------

		when	19	=>	lcd <= "1000100";
					if (sayac=com_ds/20) then
						adim	:=	20;
						end if;
		when	20	=>	lcd <= "0000100";
					if (sayac=com_ds/10) then
						adim	:=	21;
					end if;
		when	21	=>	lcd <= "1000000";
					if (sayac=3*com_ds/20) then
						adim	:=	22;
					end if;
		when	22	=>	lcd <= "0000000";
					if (sayac=com_ds) then
						adim	:=	23;
						sayac	:=	0;
					end if;
	
---------------write to ram---------------------


	
		when	23	=>	lcd <= "110"&mesaj(i)(7 downto 4);
					if (sayac=com_ds/20) then
						adim	:=	24;
					end if;
		when	24	=>	lcd <= "010"&mesaj(i)(7 downto 4);
					if (sayac=com_ds/10) then
						adim	:=	25;
					end if;
		when	25	=>	lcd <= "110"&mesaj(i)(3 downto 0);
					if (sayac=3*com_ds/20) then
						adim	:=	26;
					end if;
		when	26	=>	lcd <= "010"&mesaj(i)(3 downto 0);
					if (sayac=com_ds) then
						adim	:=	27;
						sayac	:=0;
					end if;	
					

		when	27	=>	if (i<7) then
						i:=i+1;
						adim	:=	23;
					else
						adim	:=	28;
						SAYAC :=0;
						i:=0;
					end if;
					
---------------ddram adresini set ediyor---------------------

		when	28	=>	lcd <= "1001000";
					if (sayac=com_ds/20) then
						adim	:=	29;
						end if;
		when	29	=>	lcd <= "0001000";
					if (sayac=com_ds/10) then
						adim	:=	30;
					end if;
		when	30	=>	lcd <= "1000000";
					if (sayac=3*com_ds/20) then
						adim	:=	31;
					end if;
		when	31	=>	lcd <= "0000000";
					if (sayac=com_ds) then
						adim	:=	32;
						sayac	:=	0;
					end if;
	
				
--------------Ekrana Karakter Basma Islemi--------------------------

		when	32	=>	lcd <= "110"&mesaj_ekrana(i)(7 downto 4);
					if (sayac=com_ds/20) then
						adim	:=	33;
					end if;
		when	33	=>	lcd <= "010"&mesaj_ekrana(i)(7 downto 4);
					if (sayac=com_ds/10) then
						adim	:=	34;
					end if;
		when	34	=>	lcd <= "110"&mesaj_ekrana(i)(3 downto 0);
					if (sayac=3*com_ds/20) then
						adim	:=	35;
					end if;
		when	35	=>	lcd <= "010"&mesaj_ekrana(i)(3 downto 0);
					if (sayac=com_ds) then
						adim	:=	36;
						sayac	:=0;
					end if;	
					

		when	36	=>	if (i<11) then
						i:=i+1;
						adim	:=	32;
					else
					adim:=36;
						SAYAC :=0;
					
					end if;
				
end case;
end if;
END PROCESS;
end Behavioral;
