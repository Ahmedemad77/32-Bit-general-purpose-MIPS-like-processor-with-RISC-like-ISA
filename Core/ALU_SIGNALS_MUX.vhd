----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:15:29 02/25/2020 
-- Design Name: 
-- Module Name:    ALU_SIGNALS_MUX - Behavioral 
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

entity ALU_SIGNALS_MUX is
    Port ( FUNC : in  STD_LOGIC_VECTOR (3 downto 0);
           CU_SIGNALS : in  STD_LOGIC_VECTOR (3 downto 0);
           SEL : in  STD_LOGIC;
           ALU_SIGNALS : OUT  STD_LOGIC_VECTOR (3 downto 0));
end ALU_SIGNALS_MUX;

architecture Behavioral of ALU_SIGNALS_MUX is

begin
   with sel select
      ALU_SIGNALS <= func when '0',
                CU_SIGNALS when others;

end Behavioral;

