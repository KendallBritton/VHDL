library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity X_Bit_Compare_Structural is
generic (WIDTH: positive := 1);
  Port ( a : in std_logic_vector (WIDTH downto 0);
         b : in std_logic_vector (WIDTH downto 0);
         eq : out std_logic );
end X_Bit_Compare_Structural;

-- Structural Model Implementation
-- Uses two instances of One Bit Comparator to make up Two Bit Comparator
architecture Behavioral of X_Bit_Compare_Structural is

signal eq_Bit0, eq_Bit1 : std_logic;  -- Output signals to help determine final output

begin

unit0:entity work.oneBitComparator port map(x => a(0), y => b(0), eq => eq_Bit0 );  -- Instance 1 of One Bit Comparator

unit1:entity work.oneBitComparator port map(x => a(1), y => b(1), eq => eq_Bit1 );  -- Instance 2 of One Bit Comparator

eq <= eq_Bit0 and eq_Bit1 ;  -- Ensures outputs match each other

end Behavioral;
