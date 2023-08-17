----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2023 01:35:44 PM
-- Design Name: 
-- Module Name: fullAdder - Behavioral
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

entity fullAdder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           CarryIn : in STD_LOGIC;
           Sum : out STD_LOGIC;
           CarryOut : out STD_LOGIC);
end fullAdder;
 
architecture Behavioral of fullAdder is

signal s1, c1, c2 : std_logic;

component halfAdder
    port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Sum : out STD_LOGIC;
           Carry : out STD_LOGIC);
 end component;

begin

unit1: halfAdder 
    port map(A => A, B => B, Sum => s1, Carry => c1);
    
unit2: halfAdder 
    port map(A => s1, B => CarryIn, Sum => Sum, Carry => c2);

CarryOut <= c1 or c2;

end Behavioral;
