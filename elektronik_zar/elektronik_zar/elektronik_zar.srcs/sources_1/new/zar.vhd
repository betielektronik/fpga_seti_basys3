----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/07/2018 09:12:53 AM
-- Design Name: 
-- Module Name: zar - Behavioral
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

entity zar is
port(
    CLK100MHZ:in std_logic;
    dur:in std_logic;
    ZAR1:out std_logic_vector(6 downto 0);
    ZAR2:out std_logic_vector(6 downto 0)
);
end zar;

architecture Behavioral of zar is

signal A:std_logic;
signal B:std_logic;
signal kaydet1:integer range 0 to 5;
signal kaydet2:integer range 0 to 5;

begin
process(CLK100MHZ,dur,kaydet1,kaydet2)
    variable counter: unsigned(19 downto 0);
    variable counter1:integer range 0 to 5;--1.ZAR ���N
    variable counter2:integer range 0 to 5;--2.ZAR ���N
begin
    if rising_edge (CLK100MHZ) then   --e�er clock sinyali 0'dan 1'e ge�iyorsa
    counter := counter+1;         --counter'�n de�erini 1 art�r�r.
    end if;
    
    A <= counter(19);
    B <= counter(18);
    
    if rising_edge(A) then--1.ZAR ���N
    counter1:=counter1+1;
    end if;
    if rising_edge(B) then--2.ZAR ���N
    counter2:=counter2+1;
    end if;
    
    if rising_edge(dur) then--push button'a bas�ld��� anda zarlar�n 
        kaydet1<=counter1;                        --de�erleri belirleniyor.
    end if;
    if rising_edge(dur) then
        kaydet2<=counter2;
    end if;
    
    case (kaydet1) is
        when 0=> ZAR1<="0001000";--1
        when 1=> ZAR1<="0010100";--2
        when 2=> ZAR1<="0011100";--3
        when 3=> ZAR1<="1010101";--4
        when 4=> ZAR1<="1011101";--5
        when others=> ZAR1<="1110111";--6
    end case;
    
    case (kaydet2) is
        when 0=> ZAR2<="0001000";--1
        when 1=> ZAR2<="0010100";--2
        when 2=> ZAR2<="0011100";--3
        when 3=> ZAR2<="1010101";--4
        when 4=> ZAR2<="1011101";--5
        when others=> ZAR2<="1110111";--6
    end case;
    
end process;

end Behavioral;
