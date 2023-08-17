----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/22/2023 09:51:30 PM
-- Design Name: 
-- Module Name: mux_2x1 - Behavioral
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
use ieee.numeric_std.all;

entity mux_2x1 is
    Port ( In1 : in STD_LOGIC;
           In2 : in STD_LOGIC;
           Sel : in STD_LOGIC;
           Output : out STD_LOGIC);
end mux_2x1;

architecture Behavioral of mux_2x1 is

begin

    process (In1, In2, Sel)
    begin 

    if Sel = '0' then
    
        Output <= In1;
    
    else if Sel = '1' then
    
        Output <= In2;
    
    end if;
    end if;
    end process;

end Behavioral;
