----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2023 11:19:11 PM
-- Design Name: 
-- Module Name: rippleCarryAdderTestbench - Behavioral
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

entity rippleCarryAdderTestbench is
--  Port ( );
end rippleCarryAdderTestbench;

architecture Behavioral of rippleCarryAdderTestbench is

signal A,B,Sum : std_logic_vector (7 downto 0);
signal CarryOut, CarryIn : std_logic;

begin

    unit:entity work.rippleCarryAdder (Behavioral) port map(A => A, B => B, Sum => Sum, CarryOut => CarryOut, CarryIn => CarryIn);

process
begin

wait for 100 ns;

A <= "11001000";
B <= "00110010";
CarryIn <= '0';
wait for 200 ns;

A <= "11111111";
B <= "00000001";
CarryIn <= '0';
wait for 200 ns;

A <= "01000000";
B <= "01011010";
CarryIn <= '0';
wait for 200 ns;

A <= "10001001";
B <= "00100111";
CarryIn <= '0';
wait for 200 ns;

end process;

end Behavioral;
