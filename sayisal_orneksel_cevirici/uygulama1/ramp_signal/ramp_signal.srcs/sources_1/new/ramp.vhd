----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2018 04:08:14 PM
-- Design Name: 
-- Module Name: ramp - Behavioral
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

entity ramp is
port (
    clock:in std_logic;--50MHz
    rst	:in std_logic;
    SDI:out std_logic;
    sck:out std_logic;
    LDAC:out std_logic;
    CS:out std_logic
);
end ramp;

architecture Behavioral of ramp is
signal SCK1:std_logic;
signal SCK_int:std_logic;

signal SCK1_buf:std_logic;
signal SCK_int_buf:std_logic;
begin

sck<=not SCK_int;

process(clock)

variable counter:unsigned(9 downto 0);
variable counter2:integer range 0 to 18;
variable ramp_counter:unsigned(11 downto 0);

begin

if rst='1' then
counter:=(others=>'0');
elsif rising_edge(clock) then
counter:=counter+1;
end if;

SCK_int<=counter(7);
SCK1<=not SCK_int;

if rst='1' then
SCK_int_buf<='0';
SCK1_buf<='0';
elsif rising_edge(clock) then
SCK_int_buf<=SCK_int;
sck1_buf<=sck1;
end if;

if rst='1' then
SCK_int<='0';
SDI<='0';
LDAC<='0';
CS<='0';
counter2:=0;
RAMP_COUNTER:=(others=>'0');
elsif rising_edge(clock) then

if SCK_int='1' and SCK_int_buf='0' then

counter2:=counter2+1;
case (counter2) is
when 0=> SDI<='0';LDAC<='1';
when 1=> SDI<='1';
when 2=> SDI<='1';
when 3=> SDI<='1';

when 4=> SDI<=RAMP_COUNTER(11);
when 5=> SDI<=RAMP_COUNTER(10);
when 6=> SDI<=RAMP_COUNTER(9);
when 7=> SDI<=RAMP_COUNTER(8);
when 8=> SDI<=RAMP_COUNTER(7);
when 9=> SDI<=RAMP_COUNTER(6);
when 10=> SDI<=RAMP_COUNTER(5);
when 11=> SDI<=RAMP_COUNTER(4);                                                 
when 12=> SDI<=RAMP_COUNTER(3);
when 13=> SDI<=RAMP_COUNTER(2);
when 14=> SDI<=RAMP_COUNTER(1);
when 15=> SDI<=RAMP_COUNTER(0);
when 16=> ramp_counter:=ramp_counter+1;
when others=> LDAC<='0';counter2:=0;
end case;


elsif SCK_int_buf='1' and SCK_int='0' then
if counter2>15  then
CS<='1';
else
CS<='0';
end if;
end if;
end if;

end process;

end Behavioral;
