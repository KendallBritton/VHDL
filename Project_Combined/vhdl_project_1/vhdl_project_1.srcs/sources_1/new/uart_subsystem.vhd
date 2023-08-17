-- This file contains the entire uart subsystem. It will include both the receiving and transmitting subsystems.
-- Need to add transmitter, transmitter fifo, ram, classification engine.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity uart_system is
  generic(W: integer := 8;
          r : integer := 9
  );   
  Port ( 
    clk, reset: in std_logic;
    rx: in std_logic;
    tx: out std_logic
--    rd_data: out std_logic_vector(W-1 downto 0)
  );
end uart_system;

architecture Behavioral of uart_system is
signal max_tick_sig: std_logic;
signal rx_dout_sig, rx_fifo_dout_sig: std_logic_vector(W-1 downto 0);
signal rx_done_tick_sig: std_logic;
signal rx_fifo_en: std_logic;
signal rx_fifo_empty, rx_fifo_full: std_logic;

signal tx_fifo_read_en, tx_fifo_write_en: std_logic;
signal tx_empty, tx_full: std_logic;
signal tx_done_tick: std_logic;
signal tx_fifo_dout: std_logic_vector(W-1 downto 0);

signal ram_en, ram_we: std_logic;
signal ram_dout_sig: std_logic_vector(W-1 downto 0);
signal rd_addr : std_logic_vector(r-1 downto 0) := (others => '0');
signal wr_addr : std_logic_vector(r-1 downto 0) := (others => '0');

type rx_states is (idle,read);
signal rx_state_reg, rx_state_next: rx_states;
type tx_states is (idle,transmit);
signal tx_state_reg, tx_state_next: tx_states;

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

-- transmitter
component uart_tx is
    port(
        clk, reset: in std_logic;
        tx_start: in std_logic;
        s_tick: in std_logic;
        din: in std_logic_vector(7 downto 0);
        tx_done_tick: out std_logic;
        tx: out std_logic);
end component;

-- ram.
component ram is 
    port (clk : in std_logic;
        we : in std_logic;      -- write enable
        addr : in std_logic_vector(r-1 downto 0);
        dpra : in std_logic_vector(r-1 downto 0);
        di : in std_logic_vector(w-1 downto 0);
        spo : out std_logic_vector(w-1 downto 0);
        dpo : out std_logic_vector(w-1 downto 0));
end component;

begin

-- Baud Rate Generator port map
baudRateGen: baudRateGenerator
    port map(clk=>clk,reset=>reset, max_tick=>max_tick_sig);
    
-- Receiver port map
receiver: uart_rx
    port map(clk=>clk, reset=>reset, rx=>rx, s_tick=>max_tick_sig, dout=>rx_dout_sig, rx_done_tick=>rx_done_tick_sig);
    

-- Receiver fifo port map
receiverInterface: fifo
    port map(clk=>clk, reset=>reset, write_en=>rx_done_tick_sig, read_en=>rx_fifo_en, data_in=>rx_dout_sig, data_out=>rx_fifo_dout_sig, empty=>rx_fifo_empty, full=>rx_fifo_full);
    
-- ram port map.
ramModule : ram 
    port map(clk=>clk, di=>rx_fifo_dout_sig,dpo=>ram_dout_sig,addr=>wr_addr,dpra=>rd_addr,we=>ram_we);

-- Transmitter fifo port map will go here.
transmitterInterface: fifo
    port map(clk=>clk, reset=>reset, write_en=>tx_fifo_write_en, read_en=>tx_fifo_read_en, data_in=>ram_dout_sig, data_out => tx_fifo_dout, empty => tx_empty, full => tx_full);
    
-- Transmitter port map will go here.
transmitter: uart_tx
    port map(clk=>clk,reset=>reset, s_tick=>max_tick_sig, tx_start=>tx_fifo_write_en,tx_done_tick=>tx_done_tick,tx=>tx,din=>tx_fifo_dout);

-- rx state register
process(clk,reset)
begin
    if(reset='1') then
        rx_state_reg <= idle;
    elsif(clk'event and clk='1') then
        rx_state_reg <= rx_state_next;
    end if;
end process;

-- next-state logic for rx
process(rx_state_reg, rx_fifo_empty)
begin
    case rx_state_reg is
        when idle =>
            -- set read state whenever there is something in the fifo.
            if (rx_fifo_empty = '0') then
                rx_state_next <= read;
            else
                rx_state_next <= idle;
            end if;
        when read =>
            -- stay in read state if fifo is not empty.
            -- if you don't do this it will just go back to read from the above process.
            if (rx_fifo_empty = '0') then
                rx_state_next <= read;
            else
                rx_state_next <= idle;
            end if;
    end case;
end process;

-- rx fifo read / ram write logic
process(clk,reset,rx_state_next, rd_addr)
begin

case rx_state_next is
    when idle =>
        rx_fifo_en <= '0';
        ram_we <= '0';
    when read =>
        -- send to ram if address is less than 512
        if (to_integer(unsigned(wr_addr)) < 512) then
            if(clk'event and clk='1') then
                -- enable fifo read and ram write.
                rx_fifo_en <= '1';
                ram_we <= '1';
                wr_addr <= std_logic_vector( to_unsigned ((to_integer(unsigned(wr_addr)) + 1), wr_addr'length)); 
            end if;

        else
            wr_addr <= (others => '0');
        end if;
end case;

end process;

-- tx state register
process(clk,reset)
begin
    if(reset='1') then
        tx_state_reg <= idle;
    elsif(clk'event and clk='1') then
        tx_state_reg <= tx_state_next;
    end if;
end process;

-- next-state logic for tx
process(tx_state_reg, ram_we)
begin
    case tx_state_reg is
        when idle =>
            -- set transmit state whenever there is data added to ram.
            if (ram_we = '1') then
                tx_state_next <= transmit;
            else
                tx_state_next <= idle;
            end if;
        when transmit =>
            -- stay in transmit state if data still added to ram.
            -- if you don't do this it will just go back to transmit from the above process.
            if (ram_we = '1') then
                tx_state_next <= transmit;
            else
                tx_state_next <= idle;
            end if;
    end case;
end process;

-- ram read logic / tx fifo write logic
process(clk,reset,tx_state_next)
begin

case tx_state_next is
    when idle =>
        tx_fifo_write_en <= '0';
--        tx_fifo_read_en <= '0';
    when transmit =>
        --  read from ram if address is less than 512
        if (to_integer(unsigned(rd_addr)) < 512) then
            -- enable tx fifo write.
            tx_fifo_write_en <= '1';
            tx_fifo_read_en <= '1';
          if(clk'event and clk='1') then
            -- read from ram by incrementing address.        
            rd_addr <= std_logic_vector( to_unsigned ((to_integer(unsigned(rd_addr)) + 1), rd_addr'length)); 
        
          end if;
         
        else
            rd_addr <= (others => '0');
        end if;
end case;

end process;

end Behavioral;