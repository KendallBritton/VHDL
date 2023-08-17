library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_subsystem_tb is
generic (
    N: integer  := 6; -- Amount of bits needed to count up to M
    M: integer := 54  -- Mod m count, m = CLk/(Sampling Rate) where Sampling Rate is 16 * (Desired Baud Rate)
);
end entity uart_subsystem_tb;

architecture testbench of uart_subsystem_tb is

  signal clk, reset, rx : std_logic;
  signal rx_data: std_logic_vector(9 downto 0);
--  signal rd_data : std_logic_vector(7 downto 0);
--  signal rx_empty, rx_full : std_logic;
  signal tx: std_logic;

begin
  unit: entity work.uart_system (Behavioral) 
    port map(clk => clk, reset => reset, rx => rx, tx=>tx);

  process
  
  begin
      wait for 100 ns;
      
    rx_data <= "1111101010";
      
    -- initial reset of values
    reset <= '1';
    clk <= '0';
    wait for 20 ns;
    
    reset <= '0';
    wait for 20 ns;
    
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
    
    for j in 0 to 10 loop
        for i in 0 to M loop
            reset <= '0';
            clk <= '1';
            wait for 10 ns;
            
            reset <= '0';
            clk <= '0';
            wait for 10 ns;
        end loop;
    end loop;
    
    wait;
  end process;

end architecture testbench;