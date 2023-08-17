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

entity halfAdderTestbench is
--  Port ( );
end halfAdderTestbench;

architecture Behavioral of halfAdderTestbench is

signal A : std_logic;
signal B : std_logic; 
signal Sum : std_logic; 
signal Carry :std_logic; 

begin

unit:entity  work.halfAdder(Behavioral) port map(A => A, B => B, Sum => Sum, Carry => Carry);

-- inputs for testbench
process
begin

A <= '0';
B <= '0';
wait for 200 ns;

A <= '1';
B <= '0';
wait for 200 ns;

A <= '0';
B <= '1';
wait for 200 ns;

A <= '1';
B <= '1';
wait for 200 ns;

end process;

-- verifier for testbench
process

variable error_status: boolean;

begin

wait on A,B;
wait for 100 ns;

if ((A = '0' and B = '0') and (Sum = '0' and Carry = '0')) or
   ((A = '1' and B = '0') and (Sum = '1' and Carry = '0')) or
   ((A = '0' and B = '1') and (Sum = '1' and Carry = '0')) or
   ((A = '1' and B = '1') and (Sum = '0' and Carry = '1'))
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
