library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ram_testbench is
--  Port ( );
end ram_testbench;

architecture Behavioral of ram_testbench is

constant ram_w : integer := 8;
constant ram_r : integer := 9;

constant fifo_w : integer := 8;
constant fifo_n : integer := 8;

signal clk : std_logic;
signal we : std_logic ;
--signal en : std_logic;
signal rd_addr : std_logic_vector(ram_r-1 downto 0) := (others => '0');
signal wr_addr : std_logic_vector(ram_r-1 downto 0) := (others => '0');
signal di : std_logic_vector(ram_w-1 downto 0);
--signal do : std_logic_vector(ram_w-1 downto 0);

signal reset : std_logic;
signal rx_data_in : std_logic_vector(fifo_w-1 downto 0);
signal rx_write_en : std_logic;
signal rx_read_en : std_logic;
--signal rx_data_out : std_logic_vector(fifo_w-1 downto 0);
signal rx_empty : std_logic;
signal rx_full : std_logic;

signal tx_data_in : std_logic_vector(fifo_w-1 downto 0);
signal tx_write_en : std_logic;
signal tx_read_en : std_logic;
signal tx_data_out : std_logic_vector(fifo_w-1 downto 0);
signal tx_empty : std_logic;
signal tx_full : std_logic;

begin

ram: entity work.ram (Behavioral) generic map(w => ram_w , r => ram_r) port map(clk => clk, we => we, addr => wr_addr, dpra=>rd_addr, di => di, dpo => tx_data_in );

fifo_rx: entity work.fifo (Behavioral) generic map(W => fifo_w, N => fifo_n) port map(clk => clk, reset => reset, data_in => rx_data_in,
                          write_en => rx_write_en, read_en => rx_read_en, data_out => di, empty => rx_empty, full => rx_full);
                          
fifo_tx: entity work.fifo (Behavioral) generic map(W => fifo_w, N => fifo_n) port map(clk => clk, reset => reset, data_in => tx_data_in,
                          write_en => tx_write_en, read_en => tx_read_en, data_out => tx_data_out, empty => tx_empty, full => tx_full);                     

process
begin

    reset <= '1';
    wait for 10 ns;
    reset <= '0';
    wait for 10 ns;

    -- Write some data to the FIFO
    rx_write_en <= '1';
    rx_data_in <= "00000101";
    wait for 10 ns;
    rx_data_in <= "00000010";
    wait for 10 ns;
    rx_data_in <= "00000011";
    wait for 10 ns;
    rx_data_in <= "00000100";
    wait for 10 ns;
    rx_data_in <= "00000101";
    wait for 10 ns;
    
    rx_data_in <= "00000111";
    wait for 10 ns;
    rx_data_in <= "00000110";
    wait for 10 ns;
    rx_data_in <= "00000001";
    wait for 10 ns;
    rx_data_in <= "01000001";
    wait for 10 ns;
    rx_write_en <= '0';
    wait for 40 ns;
    
    we <= '1';
    
    -- Read data from the FIFO
    for i in 0 to 7 loop
    rx_read_en <= '1';
    wait for 10 ns;
    rx_read_en <= '0';
    wr_addr <= std_logic_vector( to_unsigned ((to_integer(unsigned(wr_addr)) + 1), wr_addr'length));
    wait for 10 ns;
    end loop;
    
    tx_write_en <= '1';
    we <= '0';
       
    for i in 0 to 7 loop
    wait for 10 ns;
    rd_addr <= std_logic_vector( to_unsigned ((to_integer(unsigned(rd_addr)) + 1), rd_addr'length));
    wait for 10 ns;
    end loop;
    tx_write_en <= '0';
    
        -- Read data from the FIFO
    for i in 0 to 7 loop
    wait for 10 ns;
    tx_read_en <= '1';
    wait for 10 ns;
    tx_read_en <= '0';
    end loop;

    wait;
end process;
  
process
begin
while true loop
  clk <= '0';
  wait for 5 ns;
  clk <= '1';
  wait for 5 ns;
end loop;
end process;


  

end Behavioral;