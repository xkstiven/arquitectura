library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity procesador4 is
    Port ( clkfpga : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           opAdd : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : out  STD_LOGIC_VECTOR (31 downto 0));
end procesador4;

architecture Behavioral of procesador4 is

component adder
    Port ( operand1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operand2 : in  STD_LOGIC_VECTOR (31 downto 0);
           resultado : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component nPC 
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
			  reset : in  STD_LOGIC;
           clkFPGA : in  STD_LOGIC;
           nextInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component PC
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           clkFPGA : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           nextInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component instructionMemory
    Port ( 
			  --clk : in STD_LOGIC;
			  address : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           outInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component windowManager
    Port ( --clk : in STD_LOGIC;
			  op : in STD_LOGIC_VECTOR (1 downto 0);
			  op3 : in STD_LOGIC_VECTOR (5 downto 0);
			  cwp : in STD_LOGIC_VECTOR (1 downto 0);
			  registerSource1 : in  STD_LOGIC_VECTOR (4 downto 0);
           registerSource2 : in  STD_LOGIC_VECTOR (4 downto 0);
           registerDestination : in  STD_LOGIC_VECTOR (4 downto 0);
			  ncwp : out STD_LOGIC_VECTOR (1 downto 0):="00";
           newRegisterSource1 : out  STD_LOGIC_VECTOR (5 downto 0);
           newRegisterSource2 : out  STD_LOGIC_VECTOR (5 downto 0);
           newRegisterDestination : out  STD_LOGIC_VECTOR (5 downto 0);
			  registroO7 : out STD_LOGIC_VECTOR(5 downto 0));
end component;

component registerFile
    Port ( clkFPGA : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           registerSource1 : in  STD_LOGIC_VECTOR (5 downto 0);
           registerSource2 : in  STD_LOGIC_VECTOR (5 downto 0);
           registerDestination : in  STD_LOGIC_VECTOR (5 downto 0);
           writeEnable : in  STD_LOGIC;
			  dataToWrite : in STD_LOGIC_VECTOR (31 downto 0);
           contentRegisterSource1 : out  STD_LOGIC_VECTOR (31 downto 0);
           contentRegisterSource2 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component unidadControl
    Port ( 
			  op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           wrEnRF : out  STD_LOGIC;
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end component;

component ALU
    Port ( operando1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operando2 : in  STD_LOGIC_VECTOR (31 downto 0);
           aluOP : in  STD_LOGIC_VECTOR (5 downto 0);
           carry : in  STD_LOGIC;
           AluResult : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component signExtensionUnit
    Port (
			  simm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           simm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component muxALU
    Port ( Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEUOperando : in  STD_LOGIC_VECTOR (31 downto 0);
           selImmediate : in  STD_LOGIC;
           OperandoALU : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component PSRModifier
    Port ( Crs1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  --reset : in std_logic;
           operand2 : in  STD_LOGIC_vector (31 downto 0);
           AluOp : in  STD_LOGIC_vector (5 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
			  NZVC : out std_logic_vector(3 downto 0));
end component;

component PSR
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           NZVC : in  STD_LOGIC_VECTOR (3 downto 0);
           nCWP : in  STD_LOGIC_VECTOR (1 downto 0);
           CWP : out  STD_LOGIC_VECTOR (1 downto 0);
           Carry : out  STD_LOGIC
          -- icc : out  STD_LOGIC_VECTOR (3 downto 0)
			 );
end component;

signal nPcOut, adderOut , PCout, IMout,dtw,crs1,crs2,muxout,seuout: std_logic_vector (31 downto 0);
signal psrOut, WMncwp :std_logic_vector(1 downto 0);
signal nrs1,nrs2, nrd,op7,UCout: std_logic_vector(5 downto 0);
signal wr,car: std_logic;
signal PSRMout : std_logic_vector(3 downto 0);
begin

PSR_map: PSR port map(
	clkfpga, reset, PSRMout, WMncwp, psrout, car
);

PSRModifier_map : PSRModifier port map(
	crs1,muxout, UCout, dtw, PSRMout
);

MA : muxALU port map(
	crs2, seuout, IMout(13),muxout
);

SEU : signExtensionUnit port map(
	IMout(12 downto 0), seuout
);

ALU_map : ALU port map(
	crs1,muxout,UCout, car,dtw
);

UC : unidadControl port map(
	IMout(31 downto 30),IMout(24 downto 19),wr, UCout
);

RF : registerFile port map(
	clkfpga,reset, nrs1,nrs2,nrd,wr, dtw, crs1,crs2
);

WM : windowManager port map(
	IMout(31 downto 30),IMout(24 downto 19),psrOut, IMout(18 downto 14),IMout(4 downto 0),IMout(29 downto 25), WMncwp, nrs1,nrs2,nrd,op7
);

Im : instructionMemory port map(
	PCout, reset, IMout
);

PC_map : PC port map(
	nPcOut, clkfpga, reset, PCout
);

adder_map : adder port map(
	opAdd, nPcOut, adderOut
);

nPC_map : nPC port map(
	adderOut, reset, clkfpga, nPcOut
);

AluResult <= dtw;


end Behavioral;

