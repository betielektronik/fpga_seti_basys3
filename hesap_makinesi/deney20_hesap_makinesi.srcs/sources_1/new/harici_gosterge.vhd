----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:58:39 06/04/2011 
-- Design Name: 
-- Module Name:    harici_gosterge - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.all;

entity harici_gosterge is
port(

toplama :in std_logic;
cikarma :in std_logic;
carpma	:in std_logic;
bolme		:in std_logic;

clock:in std_logic;

sayi_gelen	:in unsigned(15 downto 0);

bolum			:in unsigned(3 downto 0);
kalan			:in unsigned(3 downto 0);

anot 		:inout std_logic_vector(3 downto 0);
katot    :out		std_logic_vector(6 downto 0);----katotlar
dp			:out		std_logic

);
end harici_gosterge;

architecture Behavioral of harici_gosterge is


signal counter:unsigned(17 downto 0);

signal sayi_birlik:unsigned(3 downto 0);
signal sayi_onluk:unsigned(3 downto 0);
signal sayi_yuzluk:unsigned(3 downto 0);
signal sayi_binlik:unsigned(3 downto 0);

begin

process(clock,bolme,kalan,bolum,carpma,cikarma,toplama,sayi_gelen)
begin
if bolme='1' then
---BCD CONVERSION---------
if  ((kalan)<"1010") then

	sayi_birlik<=kalan;
	sayi_onluk<="0000";
	
	else
	
	sayi_birlik<=(kalan)-10;
	sayi_onluk<="0001";

end if;

if  ((bolum)<"1010") then

	sayi_yuzluk<=bolum;
	sayi_binlik<="0000";
	
	else
	
	sayi_yuzluk<=(bolum)-10;
	sayi_binlik<="0001";

end if;
end if;

if (	(carpma='1') or (cikarma='1') or ( toplama='1') ) then
sayi_birlik<=sayi_gelen(3 downto 0);
sayi_onluk<=sayi_gelen(7 downto 4);
sayi_yuzluk<=sayi_gelen(11 downto 8);
sayi_binlik<=sayi_gelen(15 downto 12);
end if;
end process;


PROCESS(clock,counter,sayi_birlik,sayi_onluk,sayi_yuzluk,sayi_binlik)

BEGIN



	--anotlarýn taranmasý

	if rising_edge(clock) then
	counter<=counter+1;
	end if;

	case (std_logic_vector'(counter(17),counter(16))) is
	when"00"		=> 		anot<="1000";
	when"01"		=> 		anot<="0100";
	when"10"		=> 		anot<="0010";
	when others	=> 	anot<="0001";

	end case;

if anot="1000" then
	case (sayi_birlik) is
	when"0000"=> katot<="0111111";dp<='0';
	when"0001"=> katot<="0000110";dp<='0';
	when"0010"=> katot<="1011011";dp<='0';
	when"0011"=> katot<="1001111";dp<='0';
	when"0100"=> katot<="1100110";dp<='0';
	when"0101"=> katot<="1101101";dp<='0';
	when"0110"=> katot<="1111101";dp<='0';
	when"0111"=> katot<="0000111";dp<='0';
	when"1000"=> katot<="1111111";dp<='0';
	when"1001"=> katot<="1101111";dp<='0';
	when others=> katot<="0000000";dp<='1';
	
	end case;
end if;

if anot="0100" then
	case (sayi_onluk) is
	when"0000"=> katot<="0111111";dp<='0';
	when"0001"=> katot<="0000110";dp<='0';
	when"0010"=> katot<="1011011";dp<='0';
	when"0011"=> katot<="1001111";dp<='0';
	when"0100"=> katot<="1100110";dp<='0';
	when"0101"=> katot<="1101101";dp<='0';
	when"0110"=> katot<="1111101";dp<='0';
	when"0111"=> katot<="0000111";dp<='0';
	when"1000"=> katot<="1111111";dp<='0';
	when"1001"=> katot<="1101111";dp<='0';
	when others=> katot<="0000000";dp<='1';
	
	end case;
end if;
if anot="0010" then
	case (sayi_yuzluk) is
	when"0000"=> katot<="0111111";dp<='0';
	when"0001"=> katot<="0000110";dp<='0';
	when"0010"=> katot<="1011011";dp<='0';
	when"0011"=> katot<="1001111";dp<='0';
	when"0100"=> katot<="1100110";dp<='0';
	when"0101"=> katot<="1101101";dp<='0';
	when"0110"=> katot<="1111101";dp<='0';
	when"0111"=> katot<="0000111";dp<='0';
	when"1000"=> katot<="1111111";dp<='0';
	when"1001"=> katot<="1101111";dp<='0';
	when others=> katot<="0000000";dp<='1';
	
	end case;
end if;

if anot="0001" then
	case (sayi_binlik) is
	when"0000"=> katot<="0111111";dp<='0';
	when"0001"=> katot<="0000110";dp<='0';
	when"0010"=> katot<="1011011";dp<='0';
	when"0011"=> katot<="1001111";dp<='0';
	when"0100"=> katot<="1100110";dp<='0';
	when"0101"=> katot<="1101101";dp<='0';
	when"0110"=> katot<="1111101";dp<='0';
	when"0111"=> katot<="0000111";dp<='0';
	when"1000"=> katot<="1111111";dp<='0';
	when"1001"=> katot<="1101111";dp<='0';
	when others=> katot<="0000000";dp<='1';
	
	end case;
end if;



END PROCESS;
	


end Behavioral;
