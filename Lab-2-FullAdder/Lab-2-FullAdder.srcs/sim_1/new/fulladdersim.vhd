----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/17/2023 03:02:22 PM
-- Design Name: 
-- Module Name: fulladdersim - Behavioral
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


entity FullAdderSim is
-- Port ( );
end FullAdderSim;


architecture Behavioral of FullAdderSim is
signal A : std_logic_vector(3 downto 0);
signal B : std_logic_vector(3 downto 0);
signal sum : std_logic_vector(3 downto 0);
signal carry : std_logic;
begin
p0:entity work.FullAdder(Behavioral) port map(A=>A,b=>b,sum=>sum,carry=>carry);


process
begin
 wait for 100ns;
 A <= "0000";
 B <= "0010";
 wait for 20ns;
 A <= "1000";
 B <= "1110";
 wait for 20ns;
 A <= "0000";
 B <= "0010";
 wait for 20ns;
 A <= "0000";
 B <= "0010";
 wait for 20ns;
 end process;
end Behavioral;

