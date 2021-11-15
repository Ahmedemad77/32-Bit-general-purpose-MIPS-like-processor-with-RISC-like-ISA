----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:03:10 02/26/2020 
-- Design Name: 
-- Module Name:    OUTPUT - Behavioral 
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

entity OUTPUT is
    Port ( RS : in  STD_LOGIC_VECTOR (31 downto 0);
	        clk,reset : std_logic ;
           M_OUT_signal : out  STD_LOGIC_VECTOR (31 downto 0);
           OE : in  STD_LOGIC);
end OUTPUT;

architecture Behavioral of OUTPUT is
signal  output_reg : STD_LOGIC_VECTOR (31 downto 0);
begin

process(clk ,reset)
begin 
if (reset = '1') then 
output_reg <=(others => '0') ;
elsif (clk'event and clk ='1') then
if (OE = '1' ) THEN 
output_reg <= RS ;
END IF;
end if; 
end process;
M_OUT_signal <= output_reg ;
end Behavioral;

