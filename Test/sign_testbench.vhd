--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:33:55 02/25/2020
-- Design Name:   
-- Module Name:   E:/programs/vhdl examples/Mips_microprocessor/sign_testbench.vhd
-- Project Name:  Mips_microprocessor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sign_test
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY sign_testbench IS
END sign_testbench;
 
ARCHITECTURE behavior OF sign_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sign_test
    PORT(
         o : OUT  std_logic_vector(2 downto 0);
         i0 : IN  std_logic_vector(2 downto 0);
         i1 : IN  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i0 : std_logic_vector(2 downto 0) := (others => '0');
   signal i1 : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal o : std_logic_vector(2 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sign_test PORT MAP (
          o => o,
          i0 => i0,
          i1 => i1
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
   i0 <= std_logic_vector(unsigned("101"));
	i1 <= std_logic_vector(unsigned("111"));

      wait;
   end process;

END;
