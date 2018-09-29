----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:30:07 06/04/2011 
-- Design Name: 
-- Module Name:    islem_blogu - Behavioral 
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

entity islem_blogu is
port(

clock :in std_logic;

toplama :in std_logic;
cikarma :in std_logic;
carpma	:in std_logic;
bolme		:in std_logic;

sign :out std_logic;

gelen1 :in unsigned (3 downto 0);
gelen2 :in unsigned (3 downto 0);

sayi_sonuc_bolum_cik	:out unsigned(3 downto 0);
sayi_sonuc_kalan_cik	:out unsigned(3 downto 0);


sayi_sonuc	:out unsigned(7 downto 0)



);
end islem_blogu;

architecture Behavioral of islem_blogu is

signal bolunen :unsigned(3 downto 0);
signal bolen :unsigned(3 downto 0);


signal sayi_sonuc_bolum :unsigned(3 downto 0);
signal sayi_sonuc_kalan :unsigned(3 downto 0);

signal state : unsigned(2 downto 0):="000";

begin

sayi_sonuc_kalan_cik<=sayi_sonuc_kalan;
sayi_sonuc_bolum_cik<=sayi_sonuc_bolum;


process(clock,toplama,cikarma,carpma,gelen1,gelen2)
begin

if toplama='1' then
    sayi_sonuc<=("0000"&gelen1)+("0000"&gelen2);
    sign<='0';
elsif cikarma='1' then
    if (gelen1<gelen2) then
        sign<='1';
        sayi_sonuc<=("0000"&gelen2)-("0000"&gelen1);
    else
        sayi_sonuc<=("0000"&gelen1)-("0000"&gelen2);
        sign<='0';
    end if;
elsif carpma='1' then
    sayi_sonuc<=gelen1*gelen2;
    sign<='0';
else 
    sayi_sonuc<="00000000";
    sign<='0';

end if;
end process;

process(clock,bolme,gelen1,gelen2)
begin
if bolme='0' then

state<="000";

 bolunen<=gelen1;
 bolen<=gelen2;
 
 sayi_sonuc_bolum<=(others=>'0');
 sayi_sonuc_kalan<=(others=>'0');


elsif rising_Edge(clock) then



 case state is
		when "000"=>--init
			if bolunen<bolen then
				sayi_sonuc_kalan<=bolunen;
			else
				bolunen<=bolunen-bolen;
				sayi_sonuc_bolum<=sayi_sonuc_bolum+1;
			end if;
				
				state<="001";
				
			when"001" =>
			if bolunen<bolen then
				sayi_sonuc_kalan<=bolunen;
			else
				bolunen<=bolunen-bolen;
				sayi_sonuc_bolum<=sayi_sonuc_bolum+1;
			end if;
				
				state<="000";
				
			when others=> state<="000";
			
			
					
					end case;
end if;
end process;

end Behavioral;

