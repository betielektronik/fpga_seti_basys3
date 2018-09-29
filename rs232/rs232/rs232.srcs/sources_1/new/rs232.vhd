----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/07/2018 09:03:37 AM
-- Design Name: 
-- Module Name: rs232 - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rs232 is
port(

    clock:in std_logic;--50MHz saat
    gelen_data:in std_logic;--seri data
    LED:out std_logic_vector(7 downto 0):="00000000"

);
end rs232;

architecture Behavioral of rs232 is

begin
process(clock)

variable counter: integer range 0 to 100000000:=0;
variable i: integer range 0 to 3:=0;

begin

if rising_edge(clock) then
counter:=counter+1;

	case (i) is
--step 0
		when 0=>--sistemin uyanması için 100 ms bekleniyor.
			
			LED<="00000000";
				if counter=1000000 then--100ms
					counter:=0;
					i:=1;
				end if;
--step1
		when 1=>--start bit'inin gelmesi bekleniyor.
 
			if gelen_data='0' then--start bit geldi!!
				i:=2;
				counter:=0;
			end if;
--step2

		when 2=>--50 ms sonra start bit tekrar kontrol ediliyor.
			    
			if counter=5000 then		  --50us
				if gelen_data='0' then --eğer bir hata yoksa data okunacak
					i:=3;
					counter:=0;
				else							--eğer bir hata varsa(gürültü gibi)
					i:=1;						--tekrar step1'e geri dönülecek..
					counter:=0;
				end if;
			end if;

--step3
-- Baudrate=9600 bps..
--zaman aralıkları 9600 baudrate'e göre 102.4us olarak ayarlanıyor.

		when others=>--bilgisayardan data okuma

			if counter=10420 then --102.4us
				LED(0)<=gelen_data;
			elsif counter=20840 then
				LED(1)<=gelen_data;
			elsif counter=30720 then
				LED(2)<=gelen_data;
			elsif counter=41680 then
				LED(3)<=gelen_data;
			elsif counter=52100 then
				LED(4)<=gelen_data;
			elsif counter=62520 then
				LED(5)<=gelen_data;
			elsif counter=72940 then
				LED(6)<=gelen_data;
			elsif counter=83360 then
				LED(7)<=gelen_data;
			end if;


			if counter=120000 then--okuma tamamlandıktan sonra step1' e tekrar dönülüyor.
				counter:=0;
				i:=1;
			end if;


		end case;

end if;


end process;

end Behavioral;

