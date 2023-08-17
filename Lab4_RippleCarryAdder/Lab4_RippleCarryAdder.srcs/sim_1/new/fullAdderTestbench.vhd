----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2023 03:58:55 PM
-- Design Name: 
-- Module Name: fullAdderTestbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fullAdderTestbench is
--  Port ( );
end fullAdderTestbench;

architecture Behavioral of fullAdderTestbench is

signal A : std_logic;
signal B : std_logic; 
signal CarryIn : std_logic;
signal Sum : std_logic; 
signal CarryOut :std_logic; 

begin

unit:entity  work.fullAdder (Behavioral) port map(A => A, B => B, CarryIn => CarryIn, Sum => Sum, CarryOut => CarryOut);

-- inputs for test
process
begin

A <= '0';
B <= '0';
CarryIn <= '0';
wait for 100 ns;

A <= '0';
B <= '0';
CarryIn <= '1';
wait for 100 ns;

A <= '0';
B <= '1';
CarryIn <= '0';
wait for 100 ns;

A <= '0';
B <= '1';
CarryIn <= '1';
wait for 100 ns;

A <= '1';
B <= '0';
CarryIn <= '0';
wait for 100 ns;

A <= '1';
B <= '0';
CarryIn <= '1';
wait for 100 ns;

A <= '1';
B <= '1';
CarryIn <= '0';
wait for 100 ns;

A <= '1';
B <= '1';
CarryIn <= '1';
wait for 100 ns;

end process;

-- verify tests
process 

variable error_status : boolean;

begin

wait on A,B,CarryIn;
wait for 50 ns;

if ((A = '0' and B = '0' and CarryIn = '0') and (Sum = '0' and CarryOut  = '0')) or
   ((A = '0' and B = '0' and CarryIn = '1') and (Sum = '1' and CarryOut  = '0')) or
   ((A = '0' and B = '1' and CarryIn = '0') and (Sum = '1' and CarryOut  = '0')) or
   ((A = '0' and B = '1' and CarryIn = '1') and (Sum = '0' and CarryOut  = '1')) or 
   ((A = '1' and B = '0' and CarryIn = '0') and (Sum = '1' and CarryOut  = '0')) or
   ((A = '1' and B = '0' and CarryIn = '1') and (Sum = '0' and CarryOut  = '1')) or
   ((A = '1' and B = '1' and CarryIn = '0') and (Sum = '0' and CarryOut  = '1')) or
   ((A = '1' and B = '1' and CarryIn = '1') and (Sum = '1' and CarryOut  = '1'))
    then
    
        error_status := false;
        
    else 
    
        error_status := true;
        
    end if;
    
    -- error reporting
    assert not error_status 
    report "test failed"
    severity note; --note, warning, error, failure. Failure aborts the simulation
 

end process;


end Behavioral;
