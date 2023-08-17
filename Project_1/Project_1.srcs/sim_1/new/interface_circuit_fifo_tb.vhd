library ieee;
use ieee.std_logic_1164.all;

entity interface_circuit_fifo_tb is
end interface_circuit_fifo_tb;

architecture Behavioral of interface_circuit_fifo_tb is

  constant W : integer := 8; -- Data width
  constant N : integer := 8; -- Number of registers

  signal clk : std_logic := '0';
  signal reset : std_logic := '1';
  signal data_in : std_logic_vector(W-1 downto 0);
  signal write_en : std_logic := '0';
  signal read_en : std_logic := '0';
  signal data_out : std_logic_vector(W-1 downto 0);
  signal empty : std_logic;
  signal full : std_logic;

begin

  uut: entity work.fifo
    generic map(W => W, N => N)
    port map(clk => clk,
             reset => reset,
             data_in => data_in,
             write_en => write_en,
             read_en => read_en,
             data_out => data_out,
             empty => empty,
             full => full);

  process
  begin
    reset <= '1';
    wait for 10 ns;
    reset <= '0';
    wait for 10 ns;

    -- Write some data to the FIFO
    write_en <= '1';
    data_in <= "00000101";
    wait for 10 ns;
    data_in <= "00000010";
    wait for 10 ns;
    data_in <= "00000011";
    wait for 10 ns;
    data_in <= "00000100";
    wait for 10 ns;
    data_in <= "00000101";
    wait for 10 ns;
    
    data_in <= "00000111";
    wait for 10 ns;
    data_in <= "00000110";
    wait for 10 ns;
    data_in <= "00000001";
    wait for 10 ns;
    data_in <= "01000001";
    wait for 10 ns;
    write_en <= '0';
    wait for 40 ns;
    
    -- Read data from the FIFO
    for i in 0 to 8 loop
    read_en <= '1';
    wait for 10 ns;
    read_en <= '0';
    wait for 10 ns;
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
