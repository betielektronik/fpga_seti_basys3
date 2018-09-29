----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2018 11:50:26 AM
-- Design Name: 
-- Module Name: sayici_devre - Behavioral
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

entity sayici_devre is
port(
    gelen_data	:in std_logic_vector(3 downto 0) := "0000";
    an			:out std_logic_vector(3 downto 0);
    seg			:out std_logic_vector(6 downto 0)
);
end sayici_devre;

architecture Behavioral of sayici_devre is

begin
    an<="1110";
process(gelen_data)
    begin
    
        case (gelen_data) is
        when"0000"=> seg<="1000000";
        when"0001"=> seg<="1111001";
        when"0010"=> seg<="0100100";
        when"0011"=> seg<="0110000";
        when"0100"=> seg<="0011001";
        when"0101"=> seg<="0010010";
        when"0110"=> seg<="0000010";
        when"0111"=> seg<="1111000";
        when"1000"=> seg<="0000000";
        when "1001"=>seg<="0010000";
        when others=>seg<="1111111";--beklenmeyen bir data gelirse 
        end case;                            --7segment led söner.
    
    end process;
end Behavioral;
