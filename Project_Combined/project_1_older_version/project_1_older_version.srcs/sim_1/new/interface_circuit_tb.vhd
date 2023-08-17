----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2023 07:45:35 PM
-- Design Name: 
-- Module Name: interface_circuit_tb - Behavioral
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

entity interface_circuit_tb is
generic(W: integer := 8); 
--  Port ( );
end interface_circuit_tb;

architecture Behavioral of interface_circuit_tb is
signal clk, reset: std_logic;
signal clr_flag, set_flag: std_logic;
signal din: std_logic_vector(W-1 downto 0); 
signal dout: std_logic_vector(W-1 downto 0); 
signal flag: std_logic;


begin
unit: entity work.flag_buff (Behavioral) port map(clk=>clk,reset=>reset,clr_flag=>clr_flag,set_flag=>set_flag,din=>din,dout=>dout,flag=>flag);

process
begin

    wait for 20 ns;  
    
    -- initial reset of values
    reset <= '1';
    clk <= '0';
    wait for 20 ns;
    
    reset <= '0';
    wait for 20ns;
   
    din <= "10100011";
    set_flag <= '1';
    wait for 20 ns;
    
    clr_flag <= '1';
    reset <= '0';
    clk <= '1';
    wait for 20 ns;
    
end process;

end Behavioral;
