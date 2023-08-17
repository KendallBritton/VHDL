library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity receiving_subsytem is
  generic(W: integer := 8);   
  Port ( 
    clk, reset: in std_logic;
    rx, rd_uart: in std_logic;
    rd_data: out std_logic_vector(W-1 downto 0);
    rx_empty: out std_logic
  );
end receiving_subsytem;

architecture Behavioral of receiving_subsytem is
signal max_tick_sig, rx_done_tick_sig: std_logic;
signal dout_sig: std_logic_vector(W-1 downto 0);

-- Baudrate generator.
component baudRateGenerator is 
    Port( clk, reset: in std_logic;
          max_tick, q : out std_logic );
end component;

-- Receiver.
component uart_rx is 
    Port (clk, reset: in std_logic;
        rx: in std_logic;
        s_tick: in std_logic;
        rx_done_tick: out std_logic;
        dout: out std_logic_vector(7 downto 0));
end component;

-- Interface circuit.
component flag_buff is
    Port (
        clk, reset: in std_logic;
        clr_flag, set_flag: in std_logic;
        din: in std_logic_vector(W-1 downto 0); 
        dout: out std_logic_vector(W-1 downto 0); 
        flag: out std_logic
    );
 end component;

begin

baudRateGen: baudRateGenerator
    port map(clk=>clk,reset=>reset, max_tick=>max_tick_sig);
    
receiver: uart_rx
    port map(clk=>clk, reset=>reset, rx=>rx, s_tick=>max_tick_sig, dout=>dout_sig, rx_done_tick=>rx_done_tick_sig);
    
interface: flag_buff
    port map(clk=>clk, reset=>reset, flag=>rx_empty, din=>dout_sig, dout=>rd_data, set_flag=>rx_done_tick_sig, clr_flag=>rd_uart);

end Behavioral;