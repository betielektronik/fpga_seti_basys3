----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2018 12:13:10 PM
-- Design Name: 
-- Module Name: step_motor - Behavioral
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
use IEEE.NUMERIC_STD.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity step_motor is
Port ( 	
           CLK100MHZ : in  STD_LOGIC;  --REAL CLOCK ON BASYS3 KART                                                 
           STOP : in  STD_LOGIC;
			  HIZLANDIR: in  STD_LOGIC;
			  DONDUR: in  STD_LOGIC;
           BOBIN : out  STD_LOGIC_VECTOR (3 downto 0)
		);
end step_motor;

architecture Behavioral of step_motor is
signal A:std_logic;
signal B:std_logic;
begin

process(CLK100MHZ,HIZLANDIR,A,B,STOP,DONDUR)

variable counter: unsigned(19 downto 0);
variable counter_v:unsigned(1 downto 0);

begin

    if rising_edge (CLK100MHZ) then   --eðer clock sinyali 0'dan 1'e geçiyorsa
        counter := counter+1;         --counter'ýn deðerini 1 artýrýr.
    end if;
--    A<=counter(18);           --Hýzlý clock olarak A sinyalini atar.


    if HIZLANDIR='1' then        --eðer hýzlandýrma anahtarý açýksa,
        B<=counter(19);                    	   --hýzlý clock aktif olur(A sinyali), 
    elsif HIZLANDIR='0' THEN      -- yoksa normal clock aktif olur.       
        B<=counter(18);
    END IF;


    if rising_edge (B) AND STOP='0' then  --Normal clock sinyali 0'dan 1'e 
        counter_v:= counter_v+1;          	  -- geçiyorsa counter_v 1 artar.
    end if;

    IF DONDUR='0' THEN         --Donurme anahtarýnýn durumuna gore 
        CASE (COUNTER_V) IS        --motorun hangi yonde döneceði belli olur.
            WHEN"00"=> BOBIN<="1001";
            WHEN"01"=> BOBIN<="1010";
            WHEN"10"=> BOBIN<="0110";
            WHEN OTHERS=> BOBIN<="0101";
        END CASE;
    
    ELSIF DONDUR='1' THEN
    
        CASE (COUNTER_V) IS
            WHEN"11"=> BOBIN<="1001";
            WHEN"10"=> BOBIN<="1010";
            WHEN"01"=> BOBIN<="0110";
            WHEN OTHERS=> BOBIN<="0101";
        END CASE;
    END IF;

END PROCESS;
end Behavioral;
