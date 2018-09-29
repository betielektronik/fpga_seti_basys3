----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/07/2018 12:14:58 PM
-- Design Name: 
-- Module Name: dc_motor - Behavioral
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
--use IEEE.std_logic_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dc_motor is
port(			
    CLK100MHZ:in std_logic;--50MHz.
    
    duty:in unsigned(3 downto 0);

    YON:in std_logic;
    motor_control:out std_logic_vector(1 downto 0)		 			
							
);
end dc_motor;

architecture Behavioral of dc_motor is

signal pwm:std_logic;

signal period: unsigned (3 downto 0):="0000";
signal count: unsigned(3 downto 0):="0000";
signal clock_1khz:std_logic;--test amacýyla üretiliyor.

begin
period<="1010";--10

PROCESS(CLK100MHZ)
variable counter:integer range 0 to 100000:=0;
BEGIN

if rising_edge(CLK100MHZ)then
if counter=50000 then
counter:=0;
clock_1khz<=not clock_1khz;
else
counter:=counter+1;
end if;
end if;
end process;

process(clock_1KHZ)
begin
	if falling_edge(clock_1KHZ)then
		if (count=(period-1)) then
			count<="0000";
		else	
			count<=count+1;
		end if;
	end if;	
end process;

process(count,duty)
begin
			if count<duty then
				pwm<='1';
			else
				pwm<='0';
			end if;
			
end process;


PROCESS(YON,PWM)
begin
if yon='1' then
motor_control(1)<=pwm;
motor_control(0)<='0';
else
motor_control(1)<='0';
motor_control(0)<=pwm;
end if;
end process;
----------------------------------------------------------

end Behavioral;
