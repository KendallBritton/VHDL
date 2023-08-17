library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ManchesterEncoder is
    Port ( str_input : in STD_LOGIC_VECTOR (7 downto 0);
           readEnable : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           str_output : out STD_LOGIC);
end ManchesterEncoder;

-- G.E Thomas Manchester Method
architecture Behavioral of ManchesterEncoder is

type state_type is (IDLE, START, S0, S1, S2, S3, S4, S5, S6, S7);   -- Definition of various states
signal output_buff_reg, output_buff_reg_next : std_logic;           -- Signals to hold current/upcoming output for the buffered logic block
signal data_reg, data_reg_next : std_logic_vector (7 downto 0);     -- Signals to hold the current/upcoming data for the data register block
signal state_reg, state_next: state_type;

begin

-- State reg block with look ahead buffer (contains data reg components)
process(clk, reset)
begin
    if (reset = '1') then
        data_reg <= (others => '0');
        state_reg <= IDLE;
    elsif (clk'event and clk = '1') then
        data_reg <= data_reg_next;
        state_reg <= state_next;
    end if;
end process;

-- Buffered Output Logic
process(clk, reset)
begin
    if (reset = '1') then           -- Resets output buffered value to starting value
        output_buff_reg <= '0';
    elsif (clk'event and clk = '1') then            -- or assigns upcoming value to output buffer
        output_buff_reg <= output_buff_reg_next;
    end if;

end process;

-- Next state logic 
process(str_input, state_reg, readEnable)
begin
    case state_reg is   -- Case statements to determine next state logic in each situation
    when IDLE => 

        if (readEnable = '1') then          -- If readEnable is high, store data input and move to START state
            data_reg_next <= str_input;
            state_next <= START;
        end if;
        
    when START =>           -- Progress to next state
    
        state_next <= S0;
        
    when S0 =>              -- Progress to next state      
    
        state_next <= S1;
        
    when S1 =>              -- Progress to next state
    
        state_next <= S2;
        
    when S2 =>              -- Progress to next state
    
        state_next <= S3;
        
    when S3 =>              -- Progress to next state
    
        state_next <= S4;
        
    when S4 =>              -- Progress to next state
    
        state_next <= S5;
        
    when S5 =>              -- Progress to next state
    
        state_next <= S6;
        
    when S6 =>              -- Progress to next state
    
        state_next <= S7;
        
    when S7 =>              -- Progress to next state
    
        state_next <= IDLE;
        data_reg_next <= (others => '0');   -- Reset upcoming data to 0
        
    end case;
end process;

-- Output Moore Logic 

process(state_next)
begin

    output_buff_reg_next <= '0';        -- Set dafault output value to 0

    case state_next is          -- Case statements to determine next state logic in each situation
    when IDLE => 
    
        output_buff_reg_next <= '0';      -- Assign output based on state
    
    when START => 
    
        output_buff_reg_next <= '0';      -- Assign output based on state
    
    when S0 => 
    
        output_buff_reg_next <= data_reg(7);    -- Assign output based on state
    
    when S1 => 
    
        output_buff_reg_next <= data_reg(6);    -- Assign output based on state
    
    when S2 => 
    
        output_buff_reg_next <= data_reg(5);    -- Assign output based on state
    
    when S3 => 
    
        output_buff_reg_next <= data_reg(4);    -- Assign output based on state
    
    when S4 => 
    
        output_buff_reg_next <= data_reg(3);    -- Assign output based on state
    
    when S5 => 
    
        output_buff_reg_next <= data_reg(2);    -- Assign output based on state
    
    when S6 => 
    
        output_buff_reg_next <= data_reg(1);    -- Assign output based on state
    
    when S7 =>    
    
        output_buff_reg_next <= data_reg(1);    -- Assign output based on state
    
    end case; 


end process; 

-- Final Output
str_output <=  '0' when state_reg = IDLE or state_reg = START else
               not (output_buff_reg xor clk);

end Behavioral;
