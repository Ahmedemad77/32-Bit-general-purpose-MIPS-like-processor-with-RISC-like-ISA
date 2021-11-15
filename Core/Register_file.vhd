
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

entity REG_FILE is

port
(
out1 : out std_logic_vector(31 downto 0);  
out2 : out std_logic_vector(31 downto 0);
regselect1 : in std_logic_vector(4 downto 0);               --select for out1 
regselect2 : in std_logic_vector(4 downto 0);               --select for out2
input : in std_logic_vector(31 downto 0);  
WE : in STD_LOGIC;                                       --write enable
regselectw : in std_logic_vector(4 downto 0);            --reg. select for writing
reset : in std_logic;
clk : in std_logic 
);

end REG_FILE;

----------------------------------------------------------------------------
----------------------------------------------------------------------------


architecture reg_arch of REG_FILE is

--t3ref ll registers
type regs_storage is array ( 0 to 31 ) of std_logic_vector(31 downto 0);
signal regs: regs_storage:= (others => X"00000000");
---------------------------------------------------------------------

begin
 
 --input and reset process-------------------------------------
 process (clk,reset,we) is
 begin
 
 if reset='1' then
 
    --for n in 0 to 31 loop
      --  regs(n) <= x"00000000";
    --end loop;
	 
 regs <=(others => X"00000000"); -- for reset
 
 elsif (clk'event and clk ='1')   then --- for input
 if (WE='1') then
 regs(to_integer(unsigned(regselectw))) <= input;
 end if;
 end if;
 
 
 end process;
-------------------------------------------------------

--output process--------------------------------------
 --process (clk) is
 --begin
 
 --if rising_edge(clk) then
 
 out1 <= regs(to_integer(unsigned(regselect1)));
 out2 <= regs(to_integer(unsigned(regselect2))); 

--out1 <= x"00000000";
 --out2 <= x"00000001"; 

 
-- end if;
 
 
 --end process;
-------------------------------------------------------


end reg_arch;

