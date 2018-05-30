library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Procesador2 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ALuResult : out  STD_LOGIC_VECTOR (31 downto 0));
end Procesador2;

architecture Behavioral of Procesador2 is

COMPONENT procesadorI
	Port ( rst : in  STD_LOGIC;
			  nPC: in STD_LOGIC_VECTOR(31 downto 0);
           CLK : in  STD_LOGIC;
			  PC : out STD_LOGIC_VECTOR(31 downto 0);
			  PC1 : out STD_LOGIC_VECTOR(31 downto 0);
           Inst : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	
COMPONENT SEU
	PORT(
		imm : IN std_logic_vector(12 downto 0);          
		immExt : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT WindowManager 
    Port ( RS1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           CWP : in  STD_LOGIC_VECTOR (4 downto 0);
           nCWP : out  STD_LOGIC_VECTOR (4 downto 0);
           nRS1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nRS2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nRD : out  STD_LOGIC_VECTOR (5 downto 0));
END COMPONENT;

COMPONENT PSRModifier
	PORT(
		ALUResult : IN std_logic_vector(31 downto 0);
		Op1 : IN std_logic_vector(31 downto 0);
		Op2 : IN std_logic_vector(31 downto 0);
		ALUOP : IN std_logic_vector(5 downto 0);          
		NZVC : OUT std_logic_vector(3 downto 0)
		);
END COMPONENT;

	
COMPONENT RegisterFile
	PORT(
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0);
		rst : IN std_logic;
		WE : in STD_LOGIC;
		dwr : IN std_logic_vector(31 downto 0);          
		crs1 : OUT std_logic_vector(31 downto 0);
		crd : out STD_LOGIC_VECTOR (31 downto 0);
		crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT Mux_Rf_Alu
	PORT(
		Crs2 : IN std_logic_vector(31 downto 0);
		Imm32 : IN std_logic_vector(31 downto 0);
		l3 : IN std_logic;          
		Crs2Out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT ALU
	PORT(
		CRs1 : IN std_logic_vector(31 downto 0);
		Ope2 : IN std_logic_vector(31 downto 0);
		carry: in std_logic_vector( 3 downto 0);
		ALUOP : IN std_logic_vector(5 downto 0);          
		ALUResult : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT ControlUnit
	Port ( OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  OP2 : in  STD_LOGIC_VECTOR (2 downto 0);
			  cond : in STD_LOGIC_VECTOR (3 downto 0);
			  icc : in STD_LOGIC_VECTOR (3 downto 0);
			  RFDEST : out STD_LOGIC;
			  WRENMEM : out STD_LOGIC;
			  WE : out STD_LOGIC;
			  RFSRC : out STD_LOGIC_VECTOR (1 downto 0);
			  PCSRC : out STD_LOGIC_VECTOR (1 downto 0);
			  ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
	END COMPONENT;
	
COMPONENT PSR 
    Port ( NZVC : in  STD_LOGIC_VECTOR (3 downto 0);
			  nCWP : in STD_LOGIC_VECTOR (4 downto 0);
			  CWP : out STD_LOGIC_VECTOR (4 downto 0);
           C : out  STD_LOGIC_VECTOR (3 downto 0);
			  CLK: in STD_LOGIC);
END COMPONENT;

COMPONENT MuxRd
	PORT(
		RD : IN std_logic_vector(5 downto 0);
		RFdest : IN std_logic;          
		nRD : OUT std_logic_vector(5 downto 0)
		);
END COMPONENT;

COMPONENT MuxDataMemory
	PORT(
		DatatoMEM : IN std_logic_vector(31 downto 0);
		AluResult : IN std_logic_vector(31 downto 0);
		PC : IN std_logic_vector(31 downto 0);
		RFsource : in STD_LOGIC_VECTOR (1 downto 0);          
		DataToReg : OUT std_logic_vector(31 downto 0)
		);

END COMPONENT;

COMPONENT MuxPC
	PORT(
		Call : IN std_logic_vector(31 downto 0);
		Branch : IN std_logic_vector(31 downto 0);
		PC : IN std_logic_vector(31 downto 0);
		AluResult : IN std_logic_vector(31 downto 0);
		PCsource : IN std_logic_vector(1 downto 0);          
		nPC : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT DataMem
	PORT(
		WrEna : IN std_logic;
		cRD : IN std_logic_vector(31 downto 0);
		AluResult : IN std_logic_vector(31 downto 0);
	   rst: in STD_LOGIC;          
		DataToMem : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

COMPONENT Sumador
	PORT(
		op1 : IN std_logic_vector(31 downto 0);
		op2 : IN std_logic_vector(31 downto 0);          
		result : OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

--- Signal Input
signal Instruccion: STD_LOGIC_VECTOR (31 downto 0);

--- Signal Output
signal AuxAluRe: std_logic_vector(31 downto 0);


--- signal Multiplex
signal AuxI: std_logic;
signal Auxcrs2: std_logic_vector(31 downto 0);
signal Imm332: std_logic_vector(31 downto 0);

--- signal SEU
signal AuxImm: std_logic_vector(12 downto 0);

--- Signals ALU
signal Auxcrs1: std_logic_vector(31 downto 0);
signal Auxcrs2Out: std_logic_vector(31 downto 0);
signal AuxALUOUT: std_logic_vector(5 downto 0);
signal AuxC: STD_LOGIC_VECTOR (3 downto 0);


--- signasl window
signal AuxOP3: std_logic_vector(5 downto 0);
signal AuxOP: std_logic_vector(1 downto 0);
signal AuxOP2: std_logic_vector(2 downto 0);
signal Auxrs1: std_logic_vector(4 downto 0);
signal Auxrs2: std_logic_vector(4 downto 0);
signal Auxrd: std_logic_vector(4 downto 0);
signal AuxCWP: std_logic_vector(4 downto 0);
signal AuxCond: std_logic_vector(3 downto 0);


--- signals registerfile 
signal Auxnrs1: std_logic_vector(5 downto 0);
signal Auxnrs2: std_logic_vector(5 downto 0);
signal Auxnrd: std_logic_vector(5 downto 0);
signal AuxDatatoReg: STD_LOGIC_VECTOR(31 downto 0);
signal Auxwe: STD_LOGIC;

--- signals PSR
signal AuxNZVC: STD_LOGIC_VECTOR (3 downto 0);
signal AuxnCWP: std_logic_vector(4 downto 0);

--- signals DataMemory
signal AuxcRd: STD_LOGIC_VECTOR (31 downto 0);
signal AuxWrEnDataMen: STD_LOGIC;

--- signals MuxDataMemory
signal AuxDatatoMem: STD_LOGIC_VECTOR (31 downto 0);
signal AuxRFsource: STD_LOGIC_VECTOR (1 downto 0);
signal AuxPC: STD_LOGIC_VECTOR (31 downto 0);
signal AuxPC1: STD_LOGIC_VECTOR (31 downto 0);

--- signals MuxRd
signal AuxPrenrd: STD_LOGIC_VECTOR (5 downto 0);
signal AuxRFdest: STD_LOGIC;

--- signals sumadores
signal AuxnCall: STD_LOGIC_VECTOR (31 downto 0);
signal AuxnBranch: STD_LOGIC_VECTOR (31 downto 0);

--- signal MuxPC
signal AuxCall: STD_LOGIC_VECTOR (31 downto 0);
signal AuxBranch: STD_LOGIC_VECTOR (31 downto 0);
signal AuxPCsource: STD_LOGIC_VECTOR (1 downto 0);

--- signals Procesador1
signal AuxnPC: STD_LOGIC_VECTOR (31 downto 0);

begin

AuxnCall <= Instruccion(29) & Instruccion(29) & Instruccion(29 downto 0);
AuxnBranch <=  Instruccion(21) & Instruccion(21) & Instruccion(21) & Instruccion(21) 
	& Instruccion(21) & Instruccion(21) & Instruccion(21) & Instruccion(21) & Instruccion(21) 
	& Instruccion(21) & Instruccion(21 downto 0);
AuxOP3 <= Instruccion(24 downto 19);
AuxOP2 <= Instruccion(24 downto 22);
Auxrs1 <= Instruccion(18 downto 14);
Auxrs2 <= Instruccion(4 downto 0);
Auxrd <= Instruccion(29 downto 25);
AuxOP <= Instruccion(31 downto 30);
AuxImm <= Instruccion(12 downto 0);
AuxI <= Instruccion(13);
AuxCond <= Instruccion(28 downto 25);

Inst_procesadorI: procesadorI PORT MAP(
		rst => rst,
		nPC => AuxnPC,
		CLK => clk,
		PC => AuxPC,
		PC1 => AuxPC1,
		Inst => Instruccion
	);
	
Inst_RegisterFile: RegisterFile PORT MAP(
		rs1 => Auxnrs1,
		rs2 => Auxnrs2,
		rd => Auxnrd,
		rst => rst,
		we => Auxwe,
		dwr => AuxDatatoReg,
		crs1 => Auxcrs1,
		crd => AuxcRd,
		crs2 => Auxcrs2
	);
	
Inst_SEU: SEU PORT MAP(
	imm => AuxImm,
	immExt => Imm332
);

Inst_ControlUnit: ControlUnit PORT MAP(
		OP => AuxOP,
		OP3 => AuxOP3,
		OP2 => AuxOP2,
		cond => Auxcond,
		icc => AuxC,
		RFDEST => AuxRFdest,
		WRENMEM => AuxWrEnDataMen,
		WE => Auxwe,
		RFSRC => AuxRFsource,
		PCSRC => AuxPCsource,
		ALUOP => AuxALUOUT
	);

Inst_ALU: ALU PORT MAP(
		CRs1 => Auxcrs1,
		Ope2 => Auxcrs2Out,
		Carry => AuxC,
		ALUOP => AuxALUOUT,
		ALUResult => AuxAluRe
	);

Inst_Mux_Rf_Alu: Mux_Rf_Alu PORT MAP(
		Crs2 => Auxcrs2,
		Imm32 => Imm332,
		l3 => AuxI,
		Crs2Out => Auxcrs2Out
	);

Inst_WindowManager: WindowManager PORT MAP(
	RS1 => Auxrs1,
	RS2 => Auxrs2,
	RD => Auxrd,
	OP => AuxOP,
	OP3 => AuxOP3,
	CWP => AuxCWP,
	nCWP => AuxnCWP,
	nRS1 => Auxnrs1,
	nRS2 => Auxnrs2,
	nRD => AuxPrenrd
	);
	
Inst_PSR: PSR PORT MAP(
		NZVC => AuxNZVC,
		nCWP => AuxnCWP,
		CWP => AuxCWP,
		C => AuxC,
		CLK => CLK
	);
	
Inst_PSRModifier: PSRModifier PORT MAP(
		ALUResult => AuxAluRe,
		Op1 => Auxcrs1,
		Op2 => Auxcrs2Out,
		ALUOP => AuxALUOUT,
		NZVC => AuxNZVC
	);
	
Inst_MuxRd: MuxRd PORT MAP(
		RD => AuxPrenrd,
		RFdest => AuxRFdest,
		nRD => Auxnrd
);

Inst_MuxDataMemory: MuxDataMemory PORT MAP(
		DatatoMEM => AuxDatatoMem,
		AluResult => AuxAluRe,
		PC => AuxPC,
		DataToReg => AuxDatatoReg,
		RFsource => AuxRFsource
	);
	
Inst_MuxPC: MuxPC PORT MAP(
		Call => AuxCall,
		Branch => AuxBranch,
		PC => AuxPC1,
		AluResult => AuxAluRe,
		PCsource => AuxPCsource,
		nPC => AuxnPC
	);



Inst_DataMem: DataMem PORT MAP(
		WrEna => AuxWrEnDataMen,
		cRD => AuxcRd,
		AluResult => AuxAluRe,
		rst => rst,
		DataToMem => AuxDatatoMem
	);

Inst_Sumador1: Sumador PORT MAP(
		op1 => AuxPC,
		op2 => AuxnCall,
		result => AuxCall
	);

Inst_Sumador2: Sumador PORT MAP(
		op1 => AuxPC,
		op2 => AuxnBranch,
		result => AuxBranch
	);



ALuResult <= AuxAluRe;
	
end Behavioral;


