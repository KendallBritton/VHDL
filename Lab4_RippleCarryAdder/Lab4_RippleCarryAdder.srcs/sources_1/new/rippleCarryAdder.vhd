----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2023 01:35:44 PM
-- Design Name: 
-- Module Name: rippleCarryAdder - Behavioral
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

entity rippleCarryAdder is
generic (WIDTH: positive := 7);
    Port ( A : in std_logic_vector (WIDTH downto 0);
           B : in std_logic_vector (WIDTH downto 0);
           CarryIn : in STD_LOGIC;
           Sum : out std_logic_vector (WIDTH downto 0);
           CarryOut : out STD_LOGIC);
end rippleCarryAdder;

architecture Behavioral of rippleCarryAdder is

signal c : std_logic_vector (WIDTH + 1 downto 0) := (others => '0');

begin

unit:entity work.halfAdder port map(A => A(0), B => B(0), Sum => Sum(0), Carry => c(0));

gen: for i in 1 to (WIDTH) generate 

    unit:entity work.fullAdder port map(A => A(i), B => B(i), Sum => Sum(i), CarryIn => c(i - 1), CarryOut => c(i));

end generate; 

CarryOut <= c(WIDTH);



end Behavioral;
