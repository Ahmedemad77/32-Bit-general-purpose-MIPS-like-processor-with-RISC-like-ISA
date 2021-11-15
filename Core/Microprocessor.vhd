----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:39:42 02/26/2020 
-- Design Name: 
-- Module Name:    Microprocessor - Behavioral 
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Microprocessor is
    Port ( M_Input : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           M_output : out  STD_LOGIC_VECTOR (31 downto 0));
end Microprocessor;

architecture Behavioral of Microprocessor is



	---------------------------------------------------------------------------------------------  ALU
	
	   --signal  INPUT1 :  std_logic_vector(31 downto 0);
		signal INPUT2 : std_logic_vector(31 downto 0);
		signal OPERATION :  std_logic_vector(3 downto 0);          
		signal CarryFlag :  std_logic;
	   signal zeroFlag :  std_logic;
		signal OverflowFlag : std_logic;
		signal ALU_OUT31 :  std_logic;
		signal ALU_OUTPUT :  std_logic_vector(31 downto 0);
	
	
	COMPONENT ALU
	PORT(
		INPUT1 : IN std_logic_vector(31 downto 0);
		INPUT2 : IN std_logic_vector(31 downto 0);
		OPERATION : IN std_logic_vector(3 downto 0);          
		CarryFlag : OUT std_logic;
		zeroFlag : OUT std_logic;
		OverflowFlag : OUT std_logic;
		ALU_OUT31 : OUT std_logic;
		ALU_OUTPUT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


---------------------------------------------------------------------------------------------------------CONTROL UNIT

	COMPONENT Control_unit
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		op_code : IN std_logic_vector(5 downto 0);
		ZF : IN std_logic;
		OV_F : IN std_logic;
		Alu_OUT31 : IN std_logic;          
		ALU_MUX_SIGNALS : OUT std_logic;
		ALU_SIGNALS : OUT std_logic_vector(3 downto 0);
		Alu_in2_mux : OUT std_logic;
		PC_MUX : OUT std_logic_vector(2 downto 0);
		RF_WE : OUT std_logic;
		RF_MUX_WA : OUT std_logic_vector(1 downto 0);
		RF_IN_DATA_MUX : OUT std_logic_vector(2 downto 0);
		MEM_READ : OUT std_logic;
		MEM_WRITE : OUT std_logic;
		MEM_IN_MUX : OUT std_logic;
		STACK_WRITE : OUT std_logic;
		OE : OUT std_logic;
		STACK_READ : OUT std_logic
		);
	END COMPONENT;
	  --signal clk : std_logic;
		--signal reset :  std_logic;
		--signal op_code :  std_logic_vector(5 downto 0);
		--signal ZF :  std_logic;
		--signal OV_F :  std_logic;
		--signal Alu_OUT31 :  std_logic;          
		signal ALU_MUX_SIGNALS : std_logic;
		 signal ALU_SIGNALS :  std_logic_vector(3 downto 0);
		signal Alu_in2_mux : std_logic;
		signal PC_MUX :  std_logic_vector(2 downto 0);
		signal RF_WE : std_logic;
		 signal RF_MUX_WA : std_logic_vector(1 downto 0);
		signal RF_IN_DATA_MUX :  std_logic_vector(2 downto 0);
		signal MEM_READ :  std_logic;
		signal MEM_WRITE :  std_logic;
		signal MEM_IN_MUX :  std_logic;
		signal STACK_WRITE :  std_logic;
		signal OE :  std_logic;
		signal STACK_READ :  std_logic;
		-------------------------------------------------------------------------------------------OUTPUT cirquit
	COMPONENT OUTPUT
	PORT(
		RS : IN std_logic_vector(31 downto 0);
		clk : IN std_logic;
		reset : IN std_logic;
		OE : IN std_logic;          
		M_OUT_signal : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
      --signal  OE :  std_logic;          
		--signal M_OUT_signal :  std_logic_vector(31 downto 0);
		signal out1 :  std_logic_vector(31 downto 0);
------------------------------------------------------------------------------------------------REG FYLE
	COMPONENT REG_FILE
	PORT(
		regselect1 : IN std_logic_vector(4 downto 0);
		regselect2 : IN std_logic_vector(4 downto 0);
		input : IN std_logic_vector(31 downto 0);
		WE : IN std_logic;
		regselectw : IN std_logic_vector(4 downto 0);
		reset : IN std_logic;
		clk : IN std_logic;          
		out1 : OUT std_logic_vector(31 downto 0);
		out2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	   --signal regselect1 : std_logic_vector(4 downto 0);
		--signal regselect2 : std_logic_vector(4 downto 0);
		signal input :  std_logic_vector(31 downto 0);
		--signal WE :  std_logic; CU
		signal regselectw : std_logic_vector(4 downto 0);
		--reset : IN std_logic;
		--clk : IN std_logic;          
		signal out2 :  std_logic_vector(31 downto 0);
		----------------------------------------------------------------------------------------PC
			COMPONENT PC
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		SIGN_EXTENDED : IN std_logic_vector(31 downto 0);
		ins : IN std_logic_vector(25 downto 0);
		Rs : IN std_logic_vector(31 downto 0);
		PC_Mux : IN std_logic_vector(2 downto 0);          
		PC_OUTPUT: OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	   signal SIGN_EXTENDED :  std_logic_vector(31 downto 0);
		--signal ins :  std_logic_vector(25 downto 0);
		signal PC_OUTPUT :  std_logic_vector(31 downto 0);

----------------------------------------------------------------------------------------------sign extension
COMPONENT signextension
	PORT(
		se_in : IN std_logic_vector(15 downto 0);          
		se_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
   --signal  se_in :  std_logic_vector(15 downto 0);

	
--------------------------------------------------------------------------------------------------------Instruction Memory
COMPONENT instructionmemory
	PORT(
	clk : in std_logic ;
		pc : IN std_logic_vector(31 downto 0);          
		instruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
   signal 	instruction :  std_logic_vector(31 downto 0);
----------------------------------------------------------------------------------------ALU_SIGNALS_MICROPROCESSOR
COMPONENT ALU_SIGNALS_MUX
	PORT(
		FUNC : IN std_logic_vector(3 downto 0);
		CU_SIGNALS : IN std_logic_vector(3 downto 0);
		SEL : IN std_logic;          
		ALU_SIGNALS : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	--signal FUNC :  std_logic_vector(3 downto 0);
	----------------------------------------------------------------------------IN_RF_MUX
COMPONENT IN_RF_MUX
	PORT(
		IN_Rf_mux : IN std_logic_vector(2 downto 0);
		SIGN_EXTENDED : IN std_logic_vector(31 downto 0);
		PC : IN std_logic_vector(31 downto 0);
		stack_out : IN std_logic_vector(31 downto 0);
		in_data : IN std_logic_vector(31 downto 0);
		Memory_out : IN std_logic_vector(31 downto 0);
		RS : IN std_logic_vector(31 downto 0);
		ALU_OUT : IN std_logic_vector(31 downto 0);          
		IN_RF : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	   signal stack_out :  std_logic_vector(31 downto 0);
		signal Memory_out :  std_logic_vector(31 downto 0);
---------------------------------------------------------------------------RF_MUX_WA
COMPONENT RF_WA_mux
	PORT(
		IR_15_11 : IN std_logic_vector(4 downto 0);
		IR_20_16 : IN std_logic_vector(4 downto 0);
		RF_WA_MUX : IN std_logic_vector(1 downto 0);          
		WA : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;

----------------------------------------------------------------------------MUX
COMPONENT MUX
	PORT(
		in0 : IN std_logic_vector(31 downto 0);
		in1 : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	---------------------------------------------------------------------------memory data
COMPONENT datamemory
	PORT(
			clk : IN std_logic;
		address : IN std_logic_vector(31 downto 0);
		writedata : IN std_logic_vector(31 downto 0);
		memread : IN std_logic;
		memwrite : IN std_logic;          
		readdata : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	 signal address : std_logic_vector(31 downto 0);
----------------------------------------------------------------------------stack


 COMPONENT Stack
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		stackRead : IN std_logic;
		stackWrite : IN std_logic;
		dataIn : IN std_logic_vector(31 downto 0);          
		full_f : OUT std_logic;
		empty_f : OUT std_logic;
		dataOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
		signal	full_f :  std_logic;
		signal  empty_f :  std_logic;

--------------------------------------------------------------------------




begin
-----------------------------------------------------CONTROL UNIT PORT MAP

	Inst_Control_unit: Control_unit PORT MAP(
		clk => clk ,
		reset => reset,
		op_code =>instruction( 31 downto 26) ,
		ZF =>zeroFlag ,
		OV_F => OverflowFlag,
		Alu_OUT31 =>Alu_OUT31 ,
		ALU_MUX_SIGNALS => ALU_MUX_SIGNALS,
		ALU_SIGNALS =>ALU_SIGNALS ,
		Alu_in2_mux =>Alu_in2_mux ,
		PC_MUX =>PC_MUX ,
		RF_WE => RF_WE,
		RF_MUX_WA => RF_MUX_WA,
		RF_IN_DATA_MUX => RF_IN_DATA_MUX,
		MEM_READ =>MEM_READ  ,
		MEM_WRITE => MEM_WRITE,
		MEM_IN_MUX =>MEM_IN_MUX ,
		STACK_WRITE => STACK_WRITE,
		OE => OE,
		STACK_READ =>STACK_READ 
	);
	----------------------------------------------------------OUTPUT cirquit port map
	Inst_OUTPUT: OUTPUT PORT MAP(
		RS => out1, ---for REG_FYLE OUTPUT SIGNAL
		clk => clk ,
		reset => reset,
		M_OUT_signal => M_output,
		OE => OE ---for control unit
	);
	------------------------------------------------------ALU PORT MAP 
	Inst_ALU: ALU PORT MAP(
		INPUT1 => out1,
		INPUT2 => INPUT2,
		OPERATION => OPERATION,
		CarryFlag =>CarryFlag ,
		zeroFlag =>zeroFlag ,
		OverflowFlag =>OverflowFlag ,
		ALU_OUT31 =>ALU_OUT31 ,
	   ALU_OUTPUT =>ALU_OUTPUT 
	);
	----------------------------------------------------------REG_FILE Port map
		Inst_REGFILE: REG_FILE PORT MAP(
		out1 => out1,
		out2 =>out2 ,
		regselect1 => instruction(25 downto 21),
		regselect2 =>instruction(20 downto 16)  ,
		input =>input ,
		WE =>RF_WE ,
		regselectw =>regselectw ,
		reset => reset,
		clk =>clk  
	);
	-----------------------------------------------------------PC_port map
		Inst_PC: PC PORT MAP(
		clk => clk,
		reset => reset,
		SIGN_EXTENDED => SIGN_EXTENDED,
		ins => instruction(25 downto 0),
		Rs => out1 ,
		PC_Mux =>PC_Mux ,
		PC_OUTPUT =>PC_OUTPUT 
	);
	----------------------------------------------------------------sign extension port map 
	Inst_signextension: signextension PORT MAP(
		se_in =>instruction(15 downto 0) ,
		se_out => SIGN_EXTENDED 
	);
------------------------------------------------------------------Instruction_memory port map
Inst_instructionmemory: instructionmemory PORT MAP(
		clk => clk,
		pc => PC_OUTPUT,
		instruction => instruction
	);	
	---------------------------------------------------------------------ALU_SIGNALS_MICROPROCESSOR_port map
	Inst_ALU_SIGNALS_MUX: ALU_SIGNALS_MUX PORT MAP(
		FUNC => instruction(3 downto 0),
		CU_SIGNALS =>ALU_SIGNALS ,
		SEL =>ALU_MUX_SIGNALS ,
		ALU_SIGNALS => OPERATION
	);
	----------------------------------------------------------------------IN_RF_MUX
	Inst_IN_RF_MUX: IN_RF_MUX PORT MAP(
		IN_RF =>input ,
		IN_Rf_mux => RF_IN_DATA_MUX,
		SIGN_EXTENDED => SIGN_EXTENDED,
		PC =>PC_OUTPUT ,
		stack_out =>stack_out ,
		in_data =>M_Input ,
		Memory_out => Memory_out,
		RS =>  out1,
		ALU_OUT => ALU_OUTPUT
	);

--------------------------------------------------------------------------RF_MUX_wa
Inst_RF_WA_mux: RF_WA_mux PORT MAP(
		IR_15_11 =>instruction(15 downto 11) ,
		IR_20_16 =>instruction(20 downto 16) ,
		RF_WA_MUX => RF_MUX_WA,
		WA => regselectw
	);
	-------------------------------------------------------------------PORT MAP ALU_IN2 MUX
	Inst_MUX: MUX PORT MAP(
		in0 =>out2 ,
		in1 =>SIGN_EXTENDED ,
		sel => Alu_in2_mux,
		output => INPUT2
	);
-----------------------------------------------------------------------PORT MAP MEMORY DATA MUX
Inst_MUX_2: MUX PORT MAP(
		in0 =>M_INPUT ,
		in1 => ALU_OUTPUT,
		sel => MEM_IN_MUX,
		output => address
	);

------------------------------------------------------------------------------memory data port map
Inst_datamemory: datamemory PORT MAP(
		clk=>clk,
		address => address,
		writedata =>out2 ,
		memread => MEM_READ,
		memwrite => MEM_WRITE,
		readdata => Memory_out
	);

------------------------------------------------------------------------------stack_port map
Inst_Stack: Stack PORT MAP(
		clk =>clk ,
		reset =>reset ,
		stackRead =>STACK_WRITE ,
		stackWrite => STACK_READ,
		full_f => full_f,
		empty_f => empty_f,
		dataIn => out1,
		dataOut => stack_out
	);
	-------------------------------------------------------------------------------
--M_OUT <=M_OUT_signal ;

end Behavioral;

