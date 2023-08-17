----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/22/2023 09:23:58 PM
-- Design Name: 
-- Module Name: twoToOneMux - Behavioral
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
use ieee.numeric_std .all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity twoToOneMux is
    Port ( In1 : in STD_LOGIC;
           In2 : in STD_LOGIC;
           Sel : in STD_LOGIC;
           Output : out STD_LOGIC);
end twoToOneMux;

architecture Behavioral of twoToOneMux is

begin

Output <= (In1 and (not Sel)) or (In2 and Sel ) after 20 ns;

end Behavioral;
