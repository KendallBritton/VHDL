library IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity ram is
    generic ( w : integer := 8;
    -- number of bits per RAM word
    r : integer := 9);
    -- 2^r = number of words in RAM
    port (clk : in std_logic;
    we : in std_logic;      -- write enable
    addr : in std_logic_vector(r-1 downto 0);
    dpra : in std_logic_vector(r-1 downto 0);
    di : in std_logic_vector(w-1 downto 0);
    spo : out std_logic_vector(w-1 downto 0);
    dpo : out std_logic_vector(w-1 downto 0));
end ram;

architecture Behavioral of ram is

    type ram_type is array (0 to 2**r-1) of std_logic_vector (w-1 downto 0);
    signal RAM : ram_type := (others => (others => '0'));
    
    begin
    
    process (clk)
    begin
        if (clk'event and clk = '0') then
            if (we = '1') then
                RAM(to_integer(unsigned(addr) - 1)) <= di;
            end if; 
        end if;
    end process;

    spo <= RAM(to_integer(unsigned(addr) - 1));
    dpo <= RAM(to_integer(unsigned(dpra) - 1));


end Behavioral;
