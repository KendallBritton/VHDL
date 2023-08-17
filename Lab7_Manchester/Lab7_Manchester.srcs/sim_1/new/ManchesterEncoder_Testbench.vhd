library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ManchesterEncoder_Testbench is
--  Port ( );
end ManchesterEncoder_Testbench;

architecture Behavioral of ManchesterEncoder_Testbench is

signal str_input : std_logic_vector (7 downto 0);
signal readEnable : std_logic;
signal clk : std_logic;
signal reset : std_logic;
signal str_output : std_logic;

begin

unit: entity work.ManchesterEncoder (Behavioral) port map (str_input => str_input, clk => clk,
reset => reset, str_output => str_output, readEnable => readEnable);

-- input bitstream to be encoded
str_input <= "10100111";

process
begin

-- initial reset of values 
reset  <= '1';
readEnable <= '0';
clk <= '0';
wait for 20 ns;

reset <= '0';
wait for 20 ns;

readEnable <= '1';      -- Allows input string to be read 
wait for 20 ns;


-- loop to increment clk to encode bitstream 
for i in 0 to 8 loop

reset <= '0';
clk <= '1';
wait for 20 ns;

reset <= '0';
clk <= '0';
wait for 20 ns;

end loop;

end process;


end Behavioral;
