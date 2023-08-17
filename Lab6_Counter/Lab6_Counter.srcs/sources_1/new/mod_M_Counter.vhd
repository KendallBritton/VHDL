library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mod_M_Counter is

generic (
    count_start : integer   := 0;       -- n variable
    count_end : integer   := 12       -- m variable
);

    Port (
           clk : in std_logic ;
           reset : in STD_LOGIC;
           m : in std_logic_vector (count_end downto count_start);
           n : in std_logic_vector (count_end downto count_start);
           q : out std_logic_vector (count_end downto count_start)
           );
end mod_M_Counter;

architecture Behavioral of mod_M_Counter is

signal r_reg : unsigned (count_end downto count_start);     -- output signal from state process block
signal r_next : unsigned  (count_end downto count_start);   -- output signal from next state process block

begin

-- Register state process block
process(clk, reset)
begin

if (reset = '1') then           -- reset values back to starting value
    r_reg <= unsigned(n);
elsif (clk'event and clk = '1') then    -- or assigns next value to current state
    r_reg <= r_next;
end if;

end process;

-- next state logic
process(r_reg)
begin

if (r_reg + 1 = unsigned(m)) then       -- loop value back to start
    r_next <= unsigned(n);
elsif (r_reg + 1 < unsigned(m)) then    -- or value is incremented
    r_next <= r_reg + 1;
end if;

end process;
 
q <= std_logic_vector (r_reg);     -- Outputs current count value

end Behavioral;
