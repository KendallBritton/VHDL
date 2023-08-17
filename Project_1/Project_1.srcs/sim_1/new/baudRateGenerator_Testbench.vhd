library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Baud Rate of Zybo board is 115200
-- Clk of Zybo board is 33.3333 MHz
-- M = 145
entity baudRateGenerator_Testbench is
--  Port ( );

generic (
    N: integer  := 6; -- Amount of bits needed to count up to M
    M: integer := 54  -- Mod m count, m = CLk/(Sampling Rate) where Sampling Rate is 16 * (Desired Baud Rate)
);


end baudRateGenerator_Testbench;

architecture Behavioral of baudRateGenerator_Testbench is

signal clk : std_logic;
signal reset : std_logic;
signal max_tick : std_logic;
signal q : std_logic_vector(N - 1 downto 0);

begin

unit: entity work.baudRateGenerator (Behavioral) port map (clk => clk, reset => reset, max_tick => max_tick, q => q);


process 
begin

-- initial reset of values
reset <= '1';
clk <= '0';
wait for 5 ns;

reset <= '0';
wait for 5 ns;

-- loop to increment the counter
for i in 0 to M loop

reset <= '0';
clk <= '1';
wait for 1 ns;

reset <= '0';
clk <= '0';
wait for 1 ns;

end loop;

end process;


end Behavioral;
