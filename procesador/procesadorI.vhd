library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity procesadorI is
    Port ( rst : in  STD_LOGIC;
			  nPC: in STD_LOGIC_VECTOR(31 downto 0);
           CLK : in  STD_LOGIC;
			  PC : out STD_LOGIC_VECTOR(31 downto 0);
			  PC1 : out STD_LOGIC_VECTOR(31 downto 0);
           Inst : out  STD_LOGIC_VECTOR (31 downto 0));
end procesadorI;

architecture Behavioral of procesadorI is

component Sumador
	Port ( op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           op2 : in  STD_LOGIC_VECTOR (31 downto 0):="00000000000000000000000000000000";
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Registro
	Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           dataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           dataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component InstructionMemory
	port (
		rst: in std_logic;
      Addr : in std_logic_vector(31 downto 0);
      Instruction : out std_logic_vector(31 downto 0));
end component;

signal AuxNPout: STD_LOGIC_VECTOR(31 downto 0);
Signal AuxResult: STD_LOGIC_VECTOR(31 downto 0);
signal Address: STD_LOGIC_VECTOR(31 downto 0);

begin
NextProgramCounter: Registro
	port map( CLK => CLK,
				 RST => RST,
				 DataIn => nPC,
				 DataOut => AuxNPout
				);

ProgramCounter: Registro
	port map( CLK => CLK,
				 RST => RST,
				 DataIn => AuxNPout,
				 DataOut => Address
				);

Sumador1: Sumador
	port map(OP1 => "00000000000000000000000000000001",
				OP2 => AuxNPout,
				Result => AuxResult
				);

InstructionMemory1: InstructionMemory
	port map(rst => Rst,
				Addr => Address,
				Instruction => Inst
				);

PC1 <= AuxResult;
PC <= Address;

end Behavioral;

