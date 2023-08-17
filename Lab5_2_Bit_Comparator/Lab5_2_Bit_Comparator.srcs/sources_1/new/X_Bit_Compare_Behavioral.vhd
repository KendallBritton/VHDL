library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity X_Bit_Compare_Behavioral is
generic (WIDTH: positive := 1);
    Port ( a : in std_logic_vector  (WIDTH downto 0);
           b : in std_logic_vector  (WIDTH downto 0);
           eq : out STD_LOGIC);
end X_Bit_Compare_Behavioral;

-- Behavioral Model Implementation
-- Implements truth table results
architecture Behavioral of X_Bit_Compare_Behavioral is

begin

process(a,b)  -- A,B in sensitivity list since they are subject to change
begin 

-- Truth Table Outputs
if (a = "00") and (b = "00") then
    eq <= '1';
elsif (a = "01") and (b = "01") then
    eq <= '1';
elsif (a = "10") and (b = "10") then 
    eq <= '1';
elsif (a = "11") and (b = "11") then 
    eq <= '1';
else 
    eq <= '0';
end if;

end process;

end Behavioral;
