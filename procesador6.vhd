library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity procesador6 is
    Port ( sumador : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end procesador6;

architecture Behavioral of procesador6 is

COMPONENT nPC
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;
		clkFPGA : IN std_logic;          
		nextInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT adder
	PORT(
		operand1 : IN std_logic_vector(31 downto 0);
		operand2 : IN std_logic_vector(31 downto 0);          
		resultado : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT PC
	PORT(
		address : IN std_logic_vector(31 downto 0);
		clkFPGA : IN std_logic;
		reset : IN std_logic;          
		nextInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT muxPCSource
	PORT(
		PcDisp30 : IN std_logic_vector(31 downto 0);
		PcDisp22 : IN std_logic_vector(31 downto 0);
		Pc : IN std_logic_vector(31 downto 0);
		AluResult : IN std_logic_vector(31 downto 0);
		PcSource : IN std_logic_vector(1 downto 0);          
		OutMux : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT SEUDisp22
	PORT(
		SEU22 : IN std_logic_vector(21 downto 0);          
		SEU32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT SEUDisp30
	PORT(
		SEU30 : IN std_logic_vector(29 downto 0);          
		SEU32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT unidadControl
	PORT(
		OP : IN std_logic_vector(1 downto 0);
		OP2 : IN std_logic_vector(2 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);
		COND : IN std_logic_vector(3 downto 0);
		ICC : IN std_logic_vector(3 downto 0);          
		WriteEnableDm : OUT std_logic;
		WriteEnableRf : OUT std_logic;
		RfDest : OUT std_logic;
		RfSource : OUT std_logic_vector(1 downto 0);
		PCSource : OUT std_logic_vector(1 downto 0);
		ALUOP : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
COMPONENT windowManager
	PORT(
		OP : IN std_logic_vector(1 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);
		RS1 : IN std_logic_vector(4 downto 0);
		RS2 : IN std_logic_vector(4 downto 0);
		RD : IN std_logic_vector(4 downto 0);
		CWP : IN std_logic;          
		nRS1 : OUT std_logic_vector(5 downto 0);
		nRS2 : OUT std_logic_vector(5 downto 0);
		nRD : OUT std_logic_vector(5 downto 0);
		nCWP : OUT std_logic;
		Register07 : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
COMPONENT registerFile
	PORT(
		clkFPGA : IN std_logic;
		reset : IN std_logic;
		registerSource1 : IN std_logic_vector(5 downto 0);
		registerSource2 : IN std_logic_vector(5 downto 0);
		registerDestination : IN std_logic_vector(5 downto 0);
		writeEnable : IN std_logic;
		dataToWrite : IN std_logic_vector(31 downto 0);          
		contentRegisterSource1 : OUT std_logic_vector(31 downto 0);
		contentRegisterDestination : out  STD_LOGIC_VECTOR (31 downto 0);
		contentRegisterSource2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT signExtensionUnit
	PORT(
		simm13 : IN std_logic_vector(12 downto 0);          
		simm32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT muxALU
	PORT(
		Crs2 : IN std_logic_vector(31 downto 0);
		SEUOperando : IN std_logic_vector(31 downto 0);
		selImmediate : IN std_logic;          
		OperandoALU : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT ALU
	PORT(
		operando1 : IN std_logic_vector(31 downto 0);
		operando2 : IN std_logic_vector(31 downto 0);
		aluOP : IN std_logic_vector(5 downto 0);
		carry : IN std_logic;          
		AluResult : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT dataMemory
	PORT(
		WriteEnable : IN std_logic;
		Rst : IN std_logic;
		Data : IN std_logic_vector(31 downto 0);
		Address : IN std_logic_vector(4 downto 0);          
		DataOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT PSRModifier
	PORT(
		Crs1 : IN std_logic_vector(31 downto 0);
		operand2 : IN std_logic_vector(31 downto 0);
		AluOp : IN std_logic_vector(5 downto 0);
		AluResult : IN std_logic_vector(31 downto 0);          
		NZVC : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
COMPONENT PSR
	PORT(
		CLK : IN std_logic;
		Reset : IN std_logic;
		NZVC : IN std_logic_vector(3 downto 0);
		nCWP : IN std_logic;          
		ICC : OUT std_logic_vector(3 downto 0);
		CWP : OUT std_logic;
		Carry : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT muxRFDest
	PORT(
		RD : IN std_logic_vector(5 downto 0);
		register07 : IN std_logic_vector(5 downto 0);
		RfDest : IN std_logic;          
		Mux_out : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT muxRFSource
	PORT(
		dataMemory : IN std_logic_vector(31 downto 0);
		aluResult : IN std_logic_vector(31 downto 0);
		pc : IN std_logic_vector(31 downto 0);
		rfSource : IN std_logic_vector(1 downto 0);          
		outMux : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
signal nPCin, nPCout,adderOut,PCout ,IMout,callout,branchout,seu13out,seu22out,seu30out,ALUout,outmuxPCSource: std_logic_vector(31 downto 0);
signal rfSouOut,crs1,crs2,cRD,muxALUout,DMout: std_logic_vector(31 downto 0);
signal rfSou,pcSou: std_logic_vector (1 downto 0);
signal icc,psrout : std_logic_vector(3 downto 0);
signal WRDM,WRRF,rfDes,wmncwp,car,cwpsr :std_logic;
signal alop,nrs1,nrs2,nrd,rego7,mnrd:std_logic_vector (5 downto 0);

begin

Inst_muxRFSource: muxRFSource PORT MAP(
		dataMemory => DMout ,
		aluResult => ALUout,
		pc => PCout ,
		rfSource => rfSou,
		outMux => rfSouOut
	);

Inst_muxRFDest: muxRFDest PORT MAP(
		RD => nrd,
		register07 => rego7,
		RfDest => rfDes,
		Mux_out => mnrd
	);

Inst_PSR: PSR PORT MAP(
		CLK =>clk,
		Reset =>reset ,
		NZVC => psrout,
		ICC => icc,
		nCWP => cwpsr,
		CWP => cwpsr,
		Carry => car
	);

Inst_PSRModifier: PSRModifier PORT MAP(
		Crs1 => crs1,
		operand2 => muxALUout ,
		AluOp => alop,
		AluResult => ALUout,
		NZVC =>  psrout
	);

Inst_dataMemory: dataMemory PORT MAP(
		WriteEnable => WRDM,
		Rst => reset,
		Data => cRD,
		Address =>ALUout(4 downto 0) ,
		DataOut => DMout
	);


Inst_ALU: ALU PORT MAP(
		operando1 => crs1,
		operando2 => muxALUout,
		aluOP => alop,
		carry => car,
		AluResult => ALUout
	);


Inst_muxALU: muxALU PORT MAP(
		Crs2 => crs2,
		SEUOperando => seu13out,
		selImmediate => IMout(13) ,
		OperandoALU => muxALUout
	);

Inst_signExtensionUnit: signExtensionUnit PORT MAP(
		simm13 => IMout(12 downto 0),
		simm32 => seu13out
	);

Inst_registerFile: registerFile PORT MAP(
		clkFPGA => clk,
		reset =>reset,
		registerSource1 => nrs1,
		registerSource2 => nrs2,
		registerDestination => mnrd,
		writeEnable => WRRF,
		dataToWrite => rfSouOut ,
		contentRegisterSource1 => crs1 ,
		contentRegisterDestination => cRD,
		contentRegisterSource2 => crs2
	);


Inst_windowManager: windowManager PORT MAP(
		OP => IMout(31 downto 30),
		OP3 => IMout(24 downto 19),
		RS1 => IMout(18 downto 14),
		RS2 => IMout(4 downto 0),
		RD => IMout(29 downto 25),
		CWP => cwpsr,
		nRS1 => nrs1,
		nRS2 => nrs2,
		nRD => nrd,
		nCWP => wmncwp,
		Register07 => rego7
	);


Inst_unidadControl: unidadControl PORT MAP(
		OP => IMout(31 downto 30),
		OP2 => IMout(24 downto 22),
		OP3 => IMout(24 downto 19),
		COND => IMout(28 downto 25),
		ICC => icc,
		WriteEnableDm => WRDM,
		WriteEnableRf => WRRF,
		RfDest => rfDes,
		RfSource => rfSou,
		PCSource => pcSou,
		ALUOP => alop
	);

Inst_SEUDisp30: SEUDisp30 PORT MAP(
		SEU30 => IMout(29 downto 0),
		SEU32 => seu30out
	);

	Inst_SEUDisp22: SEUDisp22 PORT MAP(
		SEU22 => IMout(21 downto 0),
		SEU32 => seu22out
	);


Inst_muxPCSource: muxPCSource PORT MAP(
		PcDisp30 => callout,
		PcDisp22 => branchout,
		Pc => adderOut,
		AluResult =>ALUout,
		PcSource => pcSou,
		OutMux => outmuxPCSource
	);

Call: adder PORT MAP(
		operand1 => seu30out,
		operand2 => PCout,
		resultado => callout
	);


Branches: adder PORT MAP(
		operand1 => PCout,
		operand2 => seu22out,
		resultado =>  branchout
	);


Inst_instructionMemory: instructionMemory PORT MAP(
		address => PCout,
		reset =>reset ,
		outInstruction => IMout
	);


Inst_PC: PC PORT MAP(
		address => nPCout,
		clkFPGA => clk,
		reset => reset,
		nextInstruction => PCout
	);


Inst_adder: adder PORT MAP(
		operand1 => nPCout,
		operand2 => sumador,
		resultado => adderOut
	);

Inst_nPC: nPC PORT MAP(
		address => nPCin,
		reset => reset,
		clkFPGA => clk,
		nextInstruction =>  nPCout
	);
	
	Salida <= rfSouOut;




end Behavioral;