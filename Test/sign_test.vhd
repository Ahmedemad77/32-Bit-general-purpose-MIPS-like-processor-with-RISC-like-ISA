----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:31:55 02/25/2020 
-- Design Name: 
-- Module Name:    sign_test - Behavioral 
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

entity sign_test is
    Port ( o : out  STD_LOGIC_VECTOR (2 downto 0);
           i0 : in  STD_LOGIC_VECTOR (2 downto 0);
           i1 : in  STD_LOGIC_VECTOR (2 downto 0));
end sign_test;

architecture Behavioral of sign_test is

begin
o <= STD_LOGIC_VECTOR(signed(i0)-signed(i1) );

end Behavioral;

