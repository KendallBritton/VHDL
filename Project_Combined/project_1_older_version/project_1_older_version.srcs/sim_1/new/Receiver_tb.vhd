library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity Receiver_Testbench is
--  Port ( );
    generic(
        DBIT: integer := 8; 
        SB_TICK: integer := 16
    ); 
end Receiver_Testbench;

architecture Behavioral of Receiver_Testbench is
signal clk, reset: std_logic;
signal rx: std_logic;
signal s_tick: std_logic;
signal rx_done_tick: std_logic;
signal dout: std_logic_vector(7 downto 0);

signal rx_full: std_logic_vector(9 downto 0);
signal counter: integer;
begin

unit: entity work.uart_rx (Behavioral) port map (clk => clk, reset => reset, rx => rx, s_tick => s_tick, rx_done_tick => rx_done_tick, dout => dout);

process
begin

    -- initial reset of values
    reset <= '1';
    clk <= '0';
    wait for 5 ns;
    
    reset <= '0';
    
    rx_full <= "1110101100";
    s_tick <= '1';
    counter <= 0;
    rx <= rx_full(0);
    counter <= 1;
    
    wait for 5 ns;
    
    for i in 0 to 150 loop
        
        reset <= '0';
        clk <= '1';
        wait for 1 ns;
        
        reset <= '0';
        clk <= '0';
        wait for 1 ns;
        
       if (i/(counter*16)) = 1 then
        rx <= rx_full(counter);
        counter <= counter +1;
       end if;
        
    end loop;

end process;

end Behavioral;
