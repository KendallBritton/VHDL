----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/22/2023 09:53:33 PM
-- Design Name: 
-- Module Name: mux_2x1_sim - Behavioral
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

entity mux_2x1_sim is

end mux_2x1_sim;

architecture Behavioral of mux_2x1_sim is
signal In1 : std_logic;
signal In2 : std_logic;
signal Sel : std_logic;
signal Output : std_logic ;

begin
p0:entity  work.mux_2x1(Behavioral) port map(In1=>In1, In2=>In2, Sel=>Sel, Output=>Output); 

process
begin
 wait for 100ns;
 In1  <= '1';
 In2 <= '0';
 Sel <= '1';
 wait for 20 ns;
 In1  <= '1';
 In2 <= '0';
 Sel <= '0';
 wait for 20 ns;
 In1  <= 'X';
 In2 <= 'U';
 Sel <= '1';
 wait for 20 ns;
 In1  <= 'H';
 In2 <= 'Z';
 Sel <= '0';
 wait for 20 ns;
 end process;

end Behavioral;
