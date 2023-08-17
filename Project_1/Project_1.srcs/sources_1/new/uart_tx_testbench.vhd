library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_tx_testbench is    
--  Port ( );
end uart_tx_testbench;

architecture Behavioral of uart_tx_testbench is

constant DBIT: integer := 8;
constant SB_TICK: integer := 16;
constant N : integer := 6;

signal clk : std_logic; 
signal reset : std_logic;
signal tx_start : std_logic := '1';
signal s_tick : std_logic := '0';
signal din : std_logic_vector (7 downto 0) := "10110101";
signal tx_done_tick : std_logic;
signal tx : std_logic;

begin

unit: entity work.uart_tx  (arch) generic map (DBIT => DBIT, SB_TICK => SB_TICK) port map (clk => clk, reset => reset, tx_start => tx_start,
                                  s_tick => s_tick, din => din, tx_done_tick => tx_done_tick, tx => tx);

 -- clock generator process
  process
  begin
  
    while true loop
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
    end loop;
  end process;
                                            
 -- test process
  process
  begin
    -- wait for reset to complete
    reset <= '1';
    wait for 10 ns;
    reset <= '0';
    wait for 10 ns;
    
    -- send a character
    s_tick <= '1';
    
    -- wait for the transmission to complete
    wait for 30 ns;  -- 10 bits including start and stop
    
    
    -- end the simulation
    wait;
  end process;                                 

end Behavioral;
