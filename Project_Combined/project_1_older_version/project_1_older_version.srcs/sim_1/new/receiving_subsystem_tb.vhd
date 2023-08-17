library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity receiving_subsystem_tb is
generic (
    N: integer  := 6; -- Amount of bits needed to count up to M
    M: integer := 54  -- Mod m count, m = CLk/(Sampling Rate) where Sampling Rate is 16 * (Desired Baud Rate)
);
end entity receiving_subsystem_tb;

architecture testbench of receiving_subsystem_tb is

  signal clk, reset, rx, rd_uart : std_logic;
  signal rx_data: std_logic_vector(9 downto 0);
  signal rd_data : std_logic_vector(7 downto 0);
  signal rx_empty, rx_full : std_logic;

--  constant CLOCK_PERIOD : time := 10 ns; -- 100 MHz clock

begin
  unit: entity work.receiving_subsystem (Behavioral) 
    port map(clk => clk, reset => reset, rx => rx, rd_uart => rd_uart, rd_data => rd_data, rx_empty => rx_empty, rx_full=>rx_full);

  -- Clock generator
--  clk_gen: process
--  begin
--    while now < 10000 ns loop
--      clk <= '0';
--      wait for CLOCK_PERIOD / 2;
--      clk <= '1';
--      wait for CLOCK_PERIOD / 2;
--    end loop;
--    wait;
--  end process;
  process
  
  begin
      
--    rx_data <= "10101010";
    rx_data <= "1111101010";
    rd_uart <= '0';
      
    -- initial reset of values
    reset <= '1';
    clk <= '0';
    wait for 10 ns;
    
    reset <= '0';
    wait for 10 ns;
    
    -- send data.
    for i in 0 to 9 loop
        rx <= rx_data(i);
        for i in 0 to 16*M loop
            clk <= '1';
            wait for 1 ns;
            
            clk <= '0';
            wait for 1 ns;
         end loop;
    end loop;
    
    rx_data <= "1101110110";
    
    for i in 0 to 9 loop
        rx <= rx_data(i);
        for i in 0 to 16*M loop
            clk <= '1';
            wait for 1 ns;
            
            clk <= '0';
            wait for 1 ns;
         end loop;
    end loop;
    
    rx_data <= "1101010110";
    
    for i in 0 to 9 loop
        rx <= rx_data(i);
        for i in 0 to 16*M loop
            clk <= '1';
            wait for 1 ns;
            
            clk <= '0';
            wait for 1 ns;
         end loop;
    end loop;
    
    rx_data <= "1001110100";
    
    for i in 0 to 9 loop
        rx <= rx_data(i);
        for i in 0 to 16*M loop
            clk <= '1';
            wait for 1 ns;
            
            clk <= '0';
            wait for 1 ns;
         end loop;
    end loop;
    
    rx_data <= "1011000110";
    
    for i in 0 to 9 loop
        rx <= rx_data(i);
        for i in 0 to 16*M loop
            clk <= '1';
            wait for 1 ns;
            
            clk <= '0';
            wait for 1 ns;
         end loop;
    end loop;
    
    
    rx_data <= "1101011110";
    
    for i in 0 to 9 loop
        rx <= rx_data(i);
        for i in 0 to 16*M loop
            clk <= '1';
            wait for 1 ns;
            
            clk <= '0';
            wait for 1 ns;
         end loop;
    end loop;
    
    rx_data <= "1111010010";
    
    for i in 0 to 9 loop
        rx <= rx_data(i);
        for i in 0 to 16*M loop
            clk <= '1';
            wait for 1 ns;
            
            clk <= '0';
            wait for 1 ns;
         end loop;
    end loop;
    
    rx_data <= "1001010010";
    
    for i in 0 to 9 loop
        rx <= rx_data(i);
        for i in 0 to 16*M loop
            clk <= '1';
            wait for 1 ns;
            
            clk <= '0';
            wait for 1 ns;
         end loop;
    end loop;
    
   rx_data <= "1011010110";
    
    for i in 0 to 9 loop
        rx <= rx_data(i);
        for i in 0 to 16*M loop
            clk <= '1';
            wait for 1 ns;
            
            clk <= '0';
            wait for 1 ns;
         end loop;
    end loop;
    
    -- send stop bit and read data.
    for i in 0 to 7 loop
        rd_uart <= '1';
        clk <= '1';
        wait for 5000 ns;
        
        rd_uart <= '0';
        clk <= '0';
    wait for 5000 ns;
    end loop;
    
    
    for i in 0 to M loop
        reset <= '0';
        clk <= '1';
        wait for 10 ns;
        
        reset <= '0';
        clk <= '0';
        wait for 10 ns;
    end loop;

    -- wait for empty flag to be set
--    while rx_empty = '0' loop
--        reset <= '0';
--        clk <= '1';
--        wait for 1 ns;
        
--        reset <= '0';
--        clk <= '0';
--        wait for 1 ns;
--    end loop;

--    -- read data from buffer
    wait;
  end process;

end architecture testbench;