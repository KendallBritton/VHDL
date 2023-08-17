--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all; 

--entity fifo is
--    generic (W: integer := 8;  -- Data width
--             N: integer := 8   -- Number of registers
--            );
--    port (clk, reset: in std_logic;
--          data_in: in std_logic_vector(W-1 downto 0);
--          write_en: in std_logic;
--          read_en: in std_logic;
--          data_out: out std_logic_vector(W-1 downto 0);
--          empty: out std_logic;
--          full: out std_logic
--        );
--end fifo;

--architecture Behavioral of fifo is

--    type register_array is array (0 to N-1) of std_logic_vector(W-1 downto 0);
--    signal regs: register_array;
--    signal wr_ptr, rd_ptr: unsigned(3 downto 0);
--    signal empty_reg, full_reg: std_logic;

--begin

--    process(clk, reset, write_en, full_reg, data_in)
--    begin
--        if reset = '1' then
--            wr_ptr <= (others => '0');
--            rd_ptr <= (others => '0');
--            empty_reg <= '1';
--            full_reg <= '0';
--            regs <= (others => (others => '0'));
--        elsif (clk'event and clk='1') then
--            -- Write to FIFO
--            if write_en = '1' and full_reg = '0' then
            
--                regs(to_integer(wr_ptr(2 downto 0))) <= data_in;
--                wr_ptr <= wr_ptr + 1;
                
--                if wr_ptr = N then 
--                    wr_ptr <= (others => '0'); 
--                end if;
                
--                empty_reg <= '0';
                
--                if wr_ptr = N-1 then 
--                    full_reg <= '1'; 
--                end if;
                
--            end if;

--            -- Read from FIFO
--            if read_en = '1' and empty_reg = '0' then
            
--                data_out <= regs(to_integer(rd_ptr(2 downto 0)));
--                rd_ptr <= rd_ptr + 1;
                
--                if rd_ptr = N then 
--                    rd_ptr <= (others => '0'); 
--                end if;
                
--                full_reg <= '0';
                
--                if rd_ptr = N-1 then 
--                    empty_reg <= '1'; 
--                end if;
                
--            end if;
            
--        end if;
--    end process;

--    empty <= empty_reg;
--    full <= full_reg;

--end Behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo is
    generic (W: integer := 8;  -- Data width
             N: integer := 8   -- Number of registers
            );
    port (clk, reset: in std_logic;
          data_in: in std_logic_vector(W-1 downto 0);
          write_en: in std_logic;
          read_en: in std_logic;
          data_out: out std_logic_vector(W-1 downto 0);
          empty: out std_logic;
          full: out std_logic
        );
end fifo;

architecture Behavioral of fifo is

    type register_array is array (0 to N-1) of std_logic_vector(W-1 downto 0);
    signal regs: register_array;
    signal wr_ptr, rd_ptr: unsigned(3 downto 0);
    signal empty_reg, full_reg: std_logic;

begin

    process(clk, reset, write_en, read_en, full_reg, empty_reg, wr_ptr, rd_ptr)
    begin
        if reset = '1' then
            wr_ptr <= (others => '0');
            rd_ptr <= (others => '0');
            empty_reg <= '1';
            full_reg <= '0';
            regs <= (others => (others => '0'));
        elsif (clk'event and clk='1') then
--            -- Write to FIFO
            if write_en = '1' and full_reg = '0' then
            
                regs(to_integer(wr_ptr(2 downto 0))) <= data_in;
                wr_ptr <= wr_ptr + 1;
                
                if wr_ptr(3) /= rd_ptr(3) then 
                    full_reg <= '1'; 
                end if;
                
                if wr_ptr = N-1 then 
                    wr_ptr <= (others => '0'); 
                end if;
                
                empty_reg <= '0';
                
            end if;

            -- Read from FIFO
            if read_en = '1' and empty_reg = '0' then
            
            
                data_out <= regs(to_integer(rd_ptr(2 downto 0)));
                rd_ptr <= rd_ptr + 1;
                
                if (rd_ptr(3) = wr_ptr(3)) then 
                    empty_reg <= '1'; 
                end if;
                
                if rd_ptr = N-1 then 
                    rd_ptr <= (others => '0'); 
                end if;
                
                full_reg <= '0';
                
                
            end if;
            
        end if;
    end process;

    empty <= empty_reg;
    full <= full_reg;

end Behavioral;