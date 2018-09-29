----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2018 04:16:44 PM
-- Design Name: 
-- Module Name: square - Behavioral
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

entity square is
port (
clock:in std_logic;--50MHz
SDI:out std_logic;
sck:inout std_logic;
LDAC:out std_logic;
CS:out std_logic
);
end square;

architecture Behavioral of square is
signal SCK1:std_logic;
begin

process(clock)
variable counter:unsigned(8 downto 0);
variable counter2:integer range 0 to 18;
variable A:STD_LOGIC;

begin
if rising_edge(clock) then
counter:=counter+1;
end if;
SCK<=counter(8);
SCK1<=not SCK;

if rising_edge(SCK) then
counter2:=counter2+1;
case (counter2) is
when 0=> SDI<='0';LDAC<='1';
when 1=> SDI<='1';
when 2=> SDI<='1';
when 3=> SDI<='1';

when 4=> SDI<=A;
when 5=> SDI<=A;
when 6=> SDI<=A;
when 7=> SDI<=A;
when 8=> SDI<=A;
when 9=> SDI<=A;
when 10=> SDI<=A;
when 11=> SDI<=A;                                                 
when 12=> SDI<=A;
when 13=> SDI<=A;
when 14=> SDI<=A;
when 15=> SDI<=A;
when 16=> A:=NOT A;
when others=> LDAC<='0';
end case;
end  if;

if rising_edge (SCK1) then
if counter2>15  then
CS<='1';
else
CS<='0';
end if;
end if;
end process;

end Behavioral;
