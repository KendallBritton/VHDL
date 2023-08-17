-- This file contains the entire uart subsystem. It will include both the receiving and transmitting subsystems.
-- Need to add transmitter, transmitter fifo, ram, classification engine.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity receiving_subsystem is
  generic(W: integer := 8
  );   
  Port ( 
    clk, reset: in std_logic;
    rx, rd_uart: in std_logic;
    rd_data: out std_logic_vector(W-1 downto 0);
    rx_empty, rx_full: out std_logic
  );
end receiving_subsystem;

architecture Behavioral of receiving_subsystem is
signal max_tick_sig, rx_done_tick_sig: std_logic;
signal dout_sig: std_logic_vector(W-1 downto 0);

-- Baudrate generator.
component baudRateGenerator is 
    Port( clk, reset: in std_logic;
          max_tick : out std_logic);
end component;

-- Receiver.
component uart_rx is 
    Port (clk, reset: in std_logic;
        rx: in std_logic;
        s_tick: in std_logic;
        rx_done_tick: out std_logic;
        dout: out std_logic_vector(7 downto 0));
end component;

-- fifo interface circuit.
component fifo
    port (clk, reset: in std_logic;
          data_in: in std_logic_vector(W-1 downto 0);
          write_en: in std_logic;
          read_en: in std_logic;
          data_out: out std_logic_vector(W-1 downto 0);
          empty: out std_logic;
          full: out std_logic);
end component;

-- transmitter component will go here

-- ram will go here.

begin

-- Baud Rate Generator port map
baudRateGen: baudRateGenerator
    port map(clk=>clk,reset=>reset, max_tick=>max_tick_sig);
    
-- Receiver port map
receiver: uart_rx
    port map(clk=>clk, reset=>reset, rx=>rx, s_tick=>max_tick_sig, dout=>dout_sig, rx_done_tick=>rx_done_tick_sig);
    

-- Receiver fifo port map
receiverInterface: fifo
    port map(clk=>clk, reset=>reset, write_en=>rx_done_tick_sig, read_en=>rd_uart, data_in=>dout_sig, data_out=>rd_data, empty=>rx_empty, full=>rx_full);

-- ram port map will go here.

-- Transmitter port map will go here.

-- Transmitter fifo port map will go here.

end Behavioral;