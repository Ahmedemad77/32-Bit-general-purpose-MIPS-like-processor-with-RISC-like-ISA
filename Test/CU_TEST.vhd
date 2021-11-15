----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:22:44 02/25/2020 
-- Design Name: 
-- Module Name:    Control_unit - Behavioral 
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

entity Control_unit is
    Port (
	        clk :in std_logic ; 
	        reset : in std_logic ;
	        op_code : in  STD_LOGIC_VECTOR (5 downto 0);
           ZF : in  STD_LOGIC;
           OV_F : in  STD_LOGIC;
           Alu_OUT31 : in  STD_LOGIC;
           ALU_MUX_SIGNALS : out  STD_LOGIC;
           ALU_SIGNALS : out  STD_LOGIC_VECTOR (3 downto 0);
           Alu_in2_mux : out  STD_LOGIC;
           PC_MUX : out  STD_LOGIC_VECTOR (2 downto 0);
           RF_WE : out  STD_LOGIC;
           RF_MUX_WA : out  STD_LOGIC_VECTOR (1 downto 0);
           RF_IN_DATA_MUX : out  STD_LOGIC_VECTOR (2 downto 0);
           MEM_READ : out  STD_LOGIC;
           MEM_WRITE : out  STD_LOGIC;
           MEM_IN_MUX : out  STD_LOGIC;
           STACK_WRITE : out  STD_LOGIC;
			  OE :OUT STD_lOGIC ;
           STACK_READ : out  STD_LOGIC);
end Control_unit;

architecture Behavioral of Control_unit is
signal opcode_reg ,opcode_next :STD_LOGIC_VECTOR (5 downto 0);
signal DFF_zf : std_logic ;
begin
opcode_next <= op_code ;
------------------------------------------------------setting clk reset
process(clk ,reset)
begin 
if (reset = '1') then 
STACK_WRITE <= '0' ;
STACK_READ <= '0';
MEM_READ <= '0';
MEM_WRITE <= '0';
DFF_zf<= '0' ;
RF_WE <= '0' ;
OE <= '0' ;
elsif (clk'event and clk ='1') then
opcode_reg <= opcode_next ;
DFF_zf <= ZF;
end if; 
end process;
-------------------------------------------------------------------------
-------------------------------------------------------------------------
process(opcode_reg,ZF,OV_F,Alu_OUT31)
begin 
------------------------------------------declaring default out-put signals

   case (opcode_reg) is 
      when "000000" =>                    ----------------------------------------------ALU INSTRUCTIONS
           ALU_MUX_SIGNALS     <= '0';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '0';
           PC_MUX              <= "000";
           RF_WE               <= '1';
           RF_MUX_WA           <= "00";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  OE <= '0' ;
      when "000001" =>                  ------cmp
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0001";
           Alu_in2_mux         <= '0';
           PC_MUX              <= "000";
           RF_WE               <= '0';
           RF_MUX_WA           <= "00";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  OE <= '0' ;
      when "000010" =>        ---------------addi (i)
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '1';
           PC_MUX              <= "000";
           RF_WE               <= '1';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  OE <= '0' ;
      when "000011" =>            ------------andi
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0100";
           Alu_in2_mux         <= '1';
           PC_MUX              <= "000";
           RF_WE               <= '1';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  OE <= '0' ;
      when "000100" =>         -----------cmpi
          ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0001";
           Alu_in2_mux         <= '1';
           PC_MUX              <= "000";
           RF_WE               <= '0';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  OE <= '0' ;
      when "000101" =>         -----------ORI
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0011";
           Alu_in2_mux         <= '1';
           PC_MUX              <= "000";
           RF_WE               <= '0';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  OE <= '0' ;
--------------------------------------------------------------------------------------------jump instructions-------			  
      when "000110" =>                         ----BEQ
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0001";
           Alu_in2_mux         <= '0';
           RF_WE               <= '0';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  if(zf = '1') then 
			      PC_MUX              <= "001";
			 else  PC_MUX              <= "000";
			 end if;
			 OE <= '0' ;
      when "000111" =>                      -----------BG
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0001";
           Alu_in2_mux         <= '0';
           RF_WE               <= '0';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  if(zf = '0' and Alu_OUT31 ='0') then 
			       PC_MUX              <= "001";
			 else  PC_MUX              <= "000";
			 end if ;                 
          OE <= '0' ;			 
			                                           
      when "001000" =>                            --------BNE
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0001";
           Alu_in2_mux         <= '0';
           RF_WE               <= '0';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  if(zf = '0') then 
			       PC_MUX              <= "001";
			 else  PC_MUX              <= "000";
			 end if ;
			 OE <= '0' ;			 
      when "001001" =>             -----------------BS
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0001";
           Alu_in2_mux         <= '0';
           RF_WE               <= '0';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  if(zf = '0' and Alu_OUT31 ='1') then 
			       PC_MUX              <= "001";
			 else  PC_MUX              <= "000";
			 end if ;
			 OE <= '0' ;			 

      when "001010" =>         -------------------JUMP
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '0';
           RF_WE               <= '0';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  PC_MUX              <= "010";
			  OE <= '0' ;			 

      when "001011" =>          ----------------JAL
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '0';
           RF_WE               <= '1';
           RF_MUX_WA           <= "10";
           RF_IN_DATA_MUX      <= "101";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  PC_MUX              <= "010";
			  OE <= '0' ;			 
      when "001100" =>            --------------JNZ
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '0';
           RF_WE               <= '0';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  if(dff_zf = '0' ) then 
			       PC_MUX              <= "010";
			 else  PC_MUX              <= "000";
			 end if ;
			 OE <= '0' ;			 
      when "001101" =>           ---------------JUMP RS
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '0';
           RF_WE               <= '0';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  PC_MUX              <= "011";
			  OE <= '0' ;			 
      when "001110" =>          ----------------JZ
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '0';
           RF_WE               <= '0';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  if(dff_zf = '1' ) then 
			       PC_MUX              <= "010";
			 else  PC_MUX              <= "000";
			 end if ;
			 OE <= '0' ;			 
      when "001111" =>        -----------LOOP
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "1000";
           Alu_in2_mux         <= '0';
           RF_WE               <= '1';
           RF_MUX_WA           <= "11";
           RF_IN_DATA_MUX      <= "000";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  if( ZF = '1') then 
			       PC_MUX              <= "000";
			 else  PC_MUX              <= "001";
			 end if ;
			 OE <= '0' ;			 
---------------------------------------------------------------------------------------------MEMORY INSTRUCTIONS     
	  when "010000" =>                       -----load
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '1';
           RF_WE               <= '1';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "010";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '1';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='1';
			  PC_MUX              <= "000";
			  OE <= '0' ;			 
      when "010001" =>                  -------store
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '1';
           RF_WE               <= '0';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "010";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '1';
			  MEM_IN_MUX          <='1';
			  PC_MUX              <= "000";
			  OE <= '0' ;			 
      when "010010" =>            ---------------INMEM
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '1';
           RF_WE               <= '0';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "010";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '1';
			  MEM_IN_MUX          <='0';
			  PC_MUX              <= "000";
			  OE <= '0' ;			 
      when "010011" =>             -----------pop Rd
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '1';
           RF_WE               <= '1';
           RF_MUX_WA           <= "00";
           RF_IN_DATA_MUX      <= "100";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '1';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  PC_MUX              <= "000";
			  OE <= '0' ;			 
      when "010100" =>                ---------push RS
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '1';
           RF_WE               <= '0';
           RF_MUX_WA           <= "00";
           RF_IN_DATA_MUX      <= "100";
           STACK_WRITE         <= '1' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  PC_MUX              <= "000";
			  OE <= '0' ;			 
   -----------------------------------------------------------------------------------------------
      when "010101" =>  -------------------in rd
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '1';
           RF_WE               <= '1';
           RF_MUX_WA           <= "00";
           RF_IN_DATA_MUX      <= "011";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  PC_MUX              <= "000";
			  OE <= '0' ;			 
      when "010110" =>              -------------out RS
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '0';
           RF_WE               <= '0';
           RF_MUX_WA           <= "00";
           RF_IN_DATA_MUX      <= "100";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '1';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  PC_MUX              <= "000";
			  OE <= '1' ;		
      when "010111" =>              -----------------HLT
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '1';
           RF_WE               <= '0';
           RF_MUX_WA           <= "00";
           RF_IN_DATA_MUX      <= "100";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  PC_MUX              <= "100";
      when "011000" =>          ------------------NOP
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '1';
           RF_WE               <= '0';
           RF_MUX_WA           <= "00";
           RF_IN_DATA_MUX      <= "100";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  PC_MUX              <= "000";
			  OE <= '0' ;			 
      when "011001" =>      ------------mov RD,RS
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '1';
           RF_WE               <= '1';
           RF_MUX_WA           <= "00";
           RF_IN_DATA_MUX      <= "001";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  PC_MUX              <= "000";
			  OE <= '0' ;			
      when "011010" =>      ------movI
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '1';
           RF_WE               <= '1';
           RF_MUX_WA           <= "01";
           RF_IN_DATA_MUX      <= "110";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  PC_MUX              <= "000";
			  OE <= '0' ;			 
      when others =>  -----------------NOP
           ALU_MUX_SIGNALS     <= '1';
           ALU_SIGNALS         <= "0000";
           Alu_in2_mux         <= '1';
           RF_WE               <= '0';
           RF_MUX_WA           <= "00";
           RF_IN_DATA_MUX      <= "100";
           STACK_WRITE         <= '0' ;
			  STACK_READ          <= '0';
           MEM_READ            <= '0';
           MEM_WRITE           <= '0';
			  MEM_IN_MUX          <='0';
			  PC_MUX              <= "000";
			  OE <= '0' ;		
   end case;
				


end process ;
end Behavioral;

