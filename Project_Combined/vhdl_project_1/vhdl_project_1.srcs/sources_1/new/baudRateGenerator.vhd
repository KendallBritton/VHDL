library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Baud Rate of Zybo board is 115200
-- Clk of Zybo board is 100 MHz
-- M = 54
entity baudRateGenerator is

    generic (
        N: integer  := 6;  -- Amount of bits needed to count up to M
        M: integer := 54   -- Mod m count, m = CLk/(Sampling Rate) where Sampling Rate is 16 * (Desired Baud Rate)
    );

  Port (
        clk, reset: in std_logic ;
        max_tick: out std_logic;
        q: out std_logic_vector (N-1 downto 0)
        );
end baudRateGenerator;

architecture Behavioral of baudRateGenerator is

signal r_reg: unsigned(N-1 downto 0);
signal r_next: unsigned(N-1 downto 0);   

begin

-- State reg logic
process(clk, reset)
begin
if (reset = '1') then
    r_reg <= (others => '0');
elsif (clk'event and clk = '1') then
    r_reg <= r_next ;
end if;
end process;
    
-- Next state logic    
r_next <= (others => '0') when r_reg = (M-1) else
    r_reg + 1;

-- Output Logic    
q <= std_logic_vector(r_reg);
max_tick <= '1' when r_reg = (M - 1) else '0';

end Behavioral;
