----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/17/2023 02:58:31 PM
-- Design Name: 
-- Module Name: fulladder - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;


entity FullAdder is
 Port (
 
     A: in std_logic_vector(1 downto 0);
     B: in std_logic_vector(1 downto 0);
     sum: out std_logic_vector(1 downto 0);
     carry: out std_logic
     
 );
end FullAdder;


architecture Behavioral of FullAdder is
signal temp : std_logic_vector(2 downto 0);
begin
sum <= std_logic_vector( unsigned(A) + unsigned(B));
temp <= std_logic_vector("0"&unsigned(A)+ unsigned(B));
carry <= temp(2);


end Behavioral;
