
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Stack is

port(
		clk,reset  :in std_logic;
		stackRead,stackWrite :in std_logic;
		full_f,empty_f : out std_logic := '0';
		dataIn: in std_logic_vector((32-1)downto 0);
		dataOut: out std_logic_vector((32-1)downto 0)
		);			
end Stack;

architecture Behavioral of Stack is
	type stack is array (0 to (1024 -1)) of std_logic_vector ((32-1)downto 0);
	signal ourStack : stack ;
	signal full : std_logic :='0';
	signal empty : std_logic :='1';
	
begin
	process(clk ,reset)
	variable SP : integer:=0; --range (0 to (1024-1));
	begin
		if (reset ='1') then
			full <= '0';
			empty <= '1';
			SP := 0;
		elsif (clk'event and clk = '1')then
			if (stackWrite = '1') then
				if (SP >= 1024 )then 
					null;
				else
					if(SP = 1024 -1) then
						full <= '1';
						empty <= '0';
					else
						full <= '0';
						empty <= '0';
					end if;
					ourStack(SP)<= dataIn;
					SP := SP +1;
				end if;
	
			elsif (stackRead = '1') then
				if (SP = 0)then
					null;
				else
					if(SP = 1) then
						full <= '0';
						empty <= '1';
					else
						full <= '0';
						empty <= '0';
					end if;
						SP := SP -1;
						dataOut <= ourStack(SP);
				end if;
			end if;
		end if;	
	end process;
	full_f  <= full;
	empty_f <= empty;
end Behavioral;

