library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity X_Bit_Compare_Dataflow is
generic (WIDTH: positive := 1);
    Port ( a : in std_logic_vector(WIDTH downto 0);
           b : in std_logic_vector(WIDTH downto 0);
           eq : out STD_LOGIC);
end X_Bit_Compare_Dataflow;

-- Dataflow Model Implementation
-- Four AND gates connected to one OR gate 
-- Each AND gets all inputs of A and B
architecture Behavioral of X_Bit_Compare_Dataflow is

signal s0, s1, s2, s3 : std_logic; -- Represents each AND gate

begin 

s3 <= (a(1) and a(0) and b(1) and b(0));  -- Gate 3
s2 <= ((not a(1)) and a(0) and (not b(1)) and b(0));  -- Gate 2
s1 <= (a(1) and (not a(0)) and b(1) and (not b(0)));  -- Gate 1
s0 <= ((not a(1)) and (not a(0)) and (not b(0)) and (not b(1)));  -- Gate 0

eq <= s3 or s2 or s1 or s0;  -- Selects output

end Behavioral;