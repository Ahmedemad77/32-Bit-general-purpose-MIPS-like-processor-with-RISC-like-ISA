----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:32:18 02/25/2020 
-- Design Name: 
-- Module Name:    IN_RF_MUX - Behavioral 
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

entity IN_RF_MUX is
    Port ( IN_RF : out  STD_LOGIC_VECTOR (31 downto 0);
	        IN_Rf_mux : in STD_LOGIC_VECTOR (2 downto 0);
           SIGN_EXTENDED : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           stack_out : in  STD_LOGIC_VECTOR (31 downto 0);
           in_data : in  STD_LOGIC_VECTOR (31 downto 0);
           Memory_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RS : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_OUT : in  STD_LOGIC_VECTOR (31 downto 0));
end IN_RF_MUX;

architecture Behavioral of IN_RF_MUX is

begin
with IN_Rf_mux select
      IN_RF <=  ALU_OUT                                            when "000",
                RS                                                 when "001",
					 MEMORY_OUT                                         when "010",
					 IN_DATA                                            when "011",
					 stack_out                                          when "100",
					 STD_LOGIC_VECTOR(unsigned(pc)+1)                   when "101",
					 SIGN_EXTENDED                                      when "110",					 
                ALU_OUT when others;
end Behavioral;

