library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_misc.all;

Entity ALU is
port(
INPUT1,INPUT2 :IN std_logic_vector(31 Downto 0);
OPERATION     :IN std_logic_vector(3 Downto 0);
CarryFlag     :out std_logic;
zeroFlag      :out std_logic;
OverflowFlag  :out std_logic;
ALU_OUT31     :out std_logic;
ALU_OUTPUT        :out std_logic_vector(31 Downto 0));
end  ALU;

architecture ALUARC of ALU is
signal Result         :std_logic_vector (31 downto 0);
--signal zeroflagsignal :std_logic;
signal tempadd        :std_logic_vector (31 downto 0);
signal tempadd2       :std_logic_vector (32 downto 0);

begin
Process(OPERATION,INPUT1,INPUT2)
begin
--default
tempadd<=('0' & INPUT1(30 downto 0))+('0' & INPUT2(30 downto 0));
tempadd2<=('0'& INPUT1(31 downto 0))+('0' & INPUT2(31 downto 0)); 
if    OPERATION = "0000" then Result <= std_logic_vector(unsigned(INPUT1) + unsigned(INPUT2)) ;   --ADD  0
                              tempadd<=('0' & INPUT1(30 downto 0))+('0' & INPUT2(30 downto 0));
                              tempadd2<=('0'& INPUT1(31 downto 0))+('0' & INPUT2(31 downto 0));                    
elsif OPERATION = "0001" then Result <= std_logic_vector(unsigned(INPUT1) - unsigned(INPUT2)) ;   --SUB  1
                              tempadd<=('0' & INPUT1(30 downto 0))-('0' & INPUT2(30 downto 0));
                              tempadd2<=('0'& INPUT1(31 downto 0))-('0' & INPUT2(31 downto 0));      
elsif OPERATION = "0010" then Result <= INPUT1 and INPUT2 ;                                       --AND  2
elsif OPERATION = "0011" then Result <= INPUT1 or  INPUT2 ;                                       --OR   3
elsif OPERATION = "0100" then Result <= INPUT1 nor INPUT2;                                        --NOR  4
elsif OPERATION = "0101" then Result <= INPUT1 xor INPUT2 ;                                       --OR   5
elsif OPERATION = "0110" then                                                                     --SLL  Shift A left  by 1   6
                              Result <= std_logic_vector(unsigned(INPUT1) sll 1);	
elsif OPERATION = "0111" then                                                                     --SRL  Shift A right by 1   7
                              Result <= std_logic_vector(unsigned(INPUT1) srl 1); 					
							  
elsif OPERATION = "1000" then Result <= INPUT1 + 1 ;                                              --INC A  8
                              tempadd<=('0' & INPUT1(30 downto 0))+ x"00000001";
                              tempadd2<=('0'& INPUT1(31 downto 0))+ "000000000000000000000000000000001";   			
				
elsif OPERATION = "1001" then Result <= INPUT1 - 1 ;                                              --DEC A  9
                              tempadd<=('0' & INPUT1(30 downto 0))- x"00000001";
                              tempadd2<=('0'& INPUT1(31 downto 0))- "000000000000000000000000000000001";  
				  
elsif OPERATION = "1010" then Result <= not INPUT1 ;                                              --NOT A  10

elsif OPERATION = "1100" then   

------you don't need it                                                                  --CMP   12  
                             -- if(input1=input2) then
                               --   zeroflagsignal <= '1' ;
	                              --Result<=x"00000000";
                               --else
                                 -- zeroflagsignal <= '0' ;
	                              Result<=std_logic_vector(unsigned(INPUT1) - unsigned(INPUT2)); 
                              -- end if;   
else  Result <= INPUT1 ;

end if;
end process;

ALU_OUTPUT <= Result;
OverflowFlag <= tempadd(31) xor tempadd2(32);
zeroFlag <= not(or_reduce(Result));
CarryFlag<= tempadd2(32);
ALU_OUT31 <= result(31);
end ALUARC;
																																								