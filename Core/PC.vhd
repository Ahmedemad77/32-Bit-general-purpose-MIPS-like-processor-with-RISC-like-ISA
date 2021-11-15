----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:06:13 02/25/2020 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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

entity PC is
    Port (  clk ,reset :in std_logic; 
	 SIGN_EXTENDED : in  STD_LOGIC_VECTOR (31 downto 0);
           ins : in  STD_LOGIC_VECTOR (25 downto 0);
           Rs : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Mux : in  STD_LOGIC_VECTOR (2 downto 0);
           PC_OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0));
end PC;

architecture Behavioral of PC is
signal pc_reg,pc_next : STD_LOGIC_VECTOR (31 downto 0);
begin
PC_OUTPUT<= pc_reg ;
-----------------------------------setting pc clk,reset
process(clk ,reset)
begin 
if (reset = '1') then 
pc_reg <=(others => '0') ;
elsif (clk'event and clk ='1') then
pc_reg <= pc_next;
end if; 
end process;
---------------------------------------pc_next
 with PC_MUX select
      pc_next <= STD_LOGIC_VECTOR( unsigned(pc_reg)+1 )                         when "000",
                STD_LOGIC_VECTOR( unsigned(pc_reg)+1+ unsigned(SIGN_EXTENDED) ) when "001",
					 PC_reg (31 downto 26) &ins                                      when "010",
					 RS                                                              when "011",
					 pc_reg                                                          when "100",
                pc_reg                                                          when others;
  
end Behavioral;

