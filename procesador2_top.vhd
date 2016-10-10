library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity procesador2_top is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           sum1 : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUresult : out  STD_LOGIC_VECTOR (31 downto 0));
end procesador2_top;

architecture Behavioral of procesador2_top is

component ALU
    Port ( operando1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operando2 : in  STD_LOGIC_VECTOR (31 downto 0);
           aluOP : in  STD_LOGIC_VECTOR (5 downto 0);
           AluResult : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component PC 
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           clkFPGA : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           nextInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component adder
    Port ( operand1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operand2 : in  STD_LOGIC_VECTOR (31 downto 0);
           resultado : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component instructionMemory
    Port ( 
			  clk : in STD_LOGIC;
			  address : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           outInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component muxALU
    Port ( Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEUOperando : in  STD_LOGIC_VECTOR (31 downto 0);
           selImmediate : in  STD_LOGIC;
           OperandoALU : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component nPC
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
			  reset : in  STD_LOGIC;
           clkFPGA : in  STD_LOGIC;
           nextInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component registerFile
    Port ( --clkFPGA : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           registerSource1 : in  STD_LOGIC_VECTOR (4 downto 0);
           registerSource2 : in  STD_LOGIC_VECTOR (4 downto 0);
           registerDestination : in  STD_LOGIC_VECTOR (4 downto 0);
           writeEnable : in  STD_LOGIC;
			  dataToWrite : in STD_LOGIC_VECTOR (31 downto 0);
           contentRegisterSource1 : out  STD_LOGIC_VECTOR (31 downto 0);
           contentRegisterSource2 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component signExtensionUnit 
    Port (
			  simm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           simm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component unidadControl
    Port ( 
			  op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           wrEnRF : out  STD_LOGIC;
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end component;

signal npcOUT, adderOUT, pcOUT, IMout,dtw,crs1,crs2,SEUout,ALUcrs2: std_logic_vector(31 downto 0);
signal wr : std_logic;
signal UCout : std_logic_vector(5 downto 0);


begin


adder_map : adder port map( 
	sum1,npcOUT , adderOUT
);

nPC_map : nPC port map(
	adderOUT, reset, clk, npcOUT
);

PC_map : PC port map(
	npcOUT, clk, reset, pcOUT
);

instrctionMemory_map : instructionMemory port map(
	clk, pcOUT, reset, IMout
);

unidadControl_map : unidadControl port map(
	IMout(31 downto 30),IMout(24 downto 19), wr, UCout
);

registerFile_map : registerFile port map(
	reset, IMout(18 downto 14), IMout(4 downto 0), IMout(29 downto 25), wr, dtw,crs1,crs2
);

signExtensionUnit_map : signExtensionUnit port map(
	IMout(12 downto 0), SEUout
);

muxALU_map : muxALU port map(
	crs2, SEUout, IMout(13), ALUcrs2
);

ALU_map : ALU port map(
	crs1, ALUcrs2, UCout,dtw
);

ALUresult <= dtw;


end Behavioral;

