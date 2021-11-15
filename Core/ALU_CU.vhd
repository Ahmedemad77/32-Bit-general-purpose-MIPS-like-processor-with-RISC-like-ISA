----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:02:01 02/25/2020 
-- Design Name: 
-- Module Name:    ALU_CU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_CU is
    Port ( func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_signals : out  STD_LOGIC_VECTOR (3 downto 0));
end ALU_CU;

architecture Behavioral of ALU_CU is

begin
with func select
      ALU_signals <=                      when "000",
                RS                            when "001",
					 MEMORY_OUT                    when "010",
					 IN_DATA                       when "011",
					 stack_out                     when "100",
					 pc_plus_one                   when "101",
					 SIGN_EXTENDED                 when "110",					 
                ALU_OUT when others;

end Behavioral;

