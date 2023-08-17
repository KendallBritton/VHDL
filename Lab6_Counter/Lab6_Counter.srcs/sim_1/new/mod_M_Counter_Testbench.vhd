library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mod_M_Counter_Testbench is
--  Port ( );

generic (
    count_start : integer := 0;       -- n variable
    count_end : integer := 12       -- m variable
);

end mod_M_Counter_Testbench;

architecture Behavioral of mod_M_Counter_Testbench is

-- signal definitions for various inputs and outputs
signal clk : std_logic;
signal reset : std_logic;
signal q  : std_logic_vector (count_end downto count_start);
signal m : std_logic_vector (count_end downto count_start);
signal n : std_logic_vector (count_end downto count_start);

begin

unit: entity work.mod_M_Counter (Behavioral) port map (clk => clk, reset => reset, m => m, n => n, q => q);

m <= std_logic_vector (to_unsigned(count_end, q'length));       -- assigns m with count_end value
n <= std_logic_vector (to_unsigned(count_start, q'length));     -- assigns n with count_start value

process 
begin

-- initial reset of values
reset <= '1';
clk <= '0';
wait for 20 ns;

reset <= '0';
wait for 20 ns;

-- loop to increment the counter
for i in 0 to 12 loop

reset <= '0';
clk <= '1';
wait for 20 ns;

clk <= '0';
reset <= '0';
wait for 20 ns;

end loop;

end process;


end Behavioral;
