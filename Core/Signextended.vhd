library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity signextension is
port ( se_in : in std_logic_vector(15 downto 0);
		 se_out : out std_logic_vector(31 downto 0)
		 );
end signextension;

architecture Behavioral of signextension is

begin

se_out<= x"0000" & se_in when se_in(15)='0' else 
			x"ffff" & se_in ;


end Behavioral;
