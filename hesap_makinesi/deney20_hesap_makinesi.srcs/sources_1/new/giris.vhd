----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:24:13 06/04/2011 
-- Design Name: 
-- Module Name:    giris - Behavioral 
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



entity giris is
port(
clock :in std_logic;


gelen1 :in unsigned (3 downto 0);
gelen2 :in unsigned (3 downto 0);

anot :inout std_logic_vector (3 downto 0);
led_out :out std_logic_vector (6 downto 0)

);

end giris;

architecture Behavioral of giris is

signal counter: unsigned (16 downto 0);--anotlarý taramak için

signal sayi1_ondalik :unsigned(3 downto 0);
signal sayi1_birlik :unsigned(3 downto 0);
signal sayi2_ondalik :unsigned(3 downto 0);
signal sayi2_birlik :unsigned(3 downto 0);


signal led :std_logic_vector(6 downto 0);

begin

led_out<=led;

process(clock,gelen1,gelen2,counter)


begin

----BCD CONVERSION---------
if ((gelen1)<"1010") then

sayi1_birlik<=gelen1;
sayi1_ondalik<="0000";

else

sayi1_birlik<=(gelen1)-10;
sayi1_ondalik<="0001";

end if;
if ((gelen2)<"1010") then

sayi2_birlik<=gelen2;
sayi2_ondalik<="0000";

else

sayi2_birlik<=(gelen2)-10;
sayi2_ondalik<="0001";

end if;
-------------------------------

--anotlarýn taranmasý

if rising_edge(clock) then
counter<=counter+1;
end if;


case (std_logic_vector'(counter(16),counter(15))) is
when"00" => anot<="1110";
when"01" => anot<="1101";
when"10" => anot<="1011";
when others => anot<="0111";

end case;

------anotlarin yanip sönme sirasina göre sayilarin ledlerde olusturulmasi

if anot="0111" then--anot0 aktif
case (sayi1_ondalik) is
when"0000"=> led<="1000000";
when"0001"=> led<="1111001";
when"0010"=> led<="0100100";
when"0011"=> led<="0110000";
when"0100"=> led<="0011001";
when"0101"=> led<="0010010";
when"0110"=> led<="0000010";
when"0111"=> led<="1111000";
when"1000"=> led<="0000000";
when others=> led<="0010000";
end case;


elsif anot="1011" then--anot1 aktif
case (sayi1_birlik) is
when"0000"=> led<="1000000";
when"0001"=> led<="1111001";
when"0010"=> led<="0100100";
when"0011"=> led<="0110000";
when"0100"=> led<="0011001";
when"0101"=> led<="0010010";
when"0110"=> led<="0000010";
when"0111"=> led<="1111000";
when"1000"=> led<="0000000";
when others=> led<="0010000";
end case;


elsif anot="1101" then--anot2 aktif
case (sayi2_ondalik) is
when"0000"=> led<="1000000";
when"0001"=> led<="1111001";
when"0010"=> led<="0100100";
when"0011"=> led<="0110000";
when"0100"=> led<="0011001";
when"0101"=> led<="0010010";
when"0110"=> led<="0000010";
when"0111"=> led<="1111000";
when"1000"=> led<="0000000";
when others=> led<="0010000";
end case;


elsif anot="1110" then--anot3 aktif
case (sayi2_birlik) is
when"0000"=> led<="1000000";
when"0001"=> led<="1111001";
when"0010"=> led<="0100100";
when"0011"=> led<="0110000";
when"0100"=> led<="0011001";
when"0101"=> led<="0010010";
when"0110"=> led<="0000010";
when"0111"=> led<="1111000";
when"1000"=> led<="0000000";
when others=> led<="0010000";
end case;
end if;

end process;


end Behavioral;


