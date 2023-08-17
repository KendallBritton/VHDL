
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity oneBitComparator is
    Port ( x : in std_logic;
           y : in std_logic;
           eq : out std_logic );
end oneBitComparator;

architecture Behavioral of oneBitComparator is

signal s0, s1 : std_logic;

begin

s0 <= (not x) and (not y);
s1 <= x and y;
eq <= s0 or s1;


end Behavioral;
