library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity X_Bit_Compare_Dataflow_Testbench is
--  Port ( );
end X_Bit_Compare_Dataflow_Testbench;

architecture Behavioral of X_Bit_Compare_Dataflow_Testbench is

signal a : std_logic_vector(1 downto 0);
signal b : std_logic_vector (1 downto 0);
signal eq : std_logic;

begin 

--unit:entity work.X_Bit_Compare_Dataflow (Behavioral) port map( a => a, b => b, eq => eq);  -- Uses the Dataflow implementation
--unit:entity work.X_Bit_Compare_Behavioral (Behavioral) port map( a => a, b => b, eq => eq);  -- Uses the Behavioral implementation
unit:entity work.X_Bit_Compare_Structural (Behavioral) port map( a => a, b => b, eq => eq);  -- Uses the Behavioral implementation


-- inputs for testbench
process
begin

a <= "00";
b <= "00";
wait for 50 ns;

a <= "00";
b <= "01";
wait for 50 ns;

a <= "00";
b <= "10";
wait for 50 ns;

a <= "00";
b <= "11";
wait for 50 ns;

a <= "01";
b <= "00";
wait for 50 ns;

a <= "01";
b <= "01";
wait for 50 ns;

a <= "01";
b <= "10";
wait for 50 ns;

a <= "01";
b <= "11";
wait for 50 ns;

a <= "10";
b <= "00";
wait for 50 ns;

a <= "10";
b <= "01";
wait for 50 ns;

a <= "10";
b <= "10";
wait for 50 ns;

a <= "10";
b <= "11";
wait for 50 ns;

a <= "11";
b <= "00";
wait for 50 ns;

a <= "11";
b <= "01";
wait for 50 ns;

a <= "11";
b <= "10";
wait for 50 ns;

a <= "11";
b <= "11";
wait for 50 ns;

end process;

-- verifier for testbench
process

variable error_status: boolean;

begin

wait on a,b;
wait for 25 ns;

if ((a = "00" and b = "00") and (eq = '1')) or
   ((a = "00" and b = "01") and (eq = '0')) or 
   ((a = "00" and b = "10") and (eq = '0')) or 
   ((a = "00" and b = "11") and (eq = '0')) or 
   ((a = "01" and b = "00") and (eq = '0')) or 
   ((a = "01" and b = "01") and (eq = '1')) or 
   ((a = "01" and b = "10") and (eq = '0')) or 
   ((a = "01" and b = "11") and (eq = '0')) or 
   ((a = "10" and b = "00") and (eq = '0')) or 
   ((a = "10" and b = "01") and (eq = '0')) or 
   ((a = "10" and b = "10") and (eq = '1')) or 
   ((a = "10" and b = "11") and (eq = '0')) or 
   ((a = "11" and b = "00") and (eq = '0')) or 
   ((a = "11" and b = "01") and (eq = '0')) or 
   ((a = "11" and b = "10") and (eq = '0')) or 
   ((a = "11" and b = "11") and (eq = '1')) 
   then 

        error_status := false;
        
   else 
   
        error_status  := true;
        
   end if;
   
   -- error reporting
   assert not error_status 
   report "test failed"
   severity note; -- note, warning, error, failure. Failure aborts the simulation
   
   end process;
end Behavioral;