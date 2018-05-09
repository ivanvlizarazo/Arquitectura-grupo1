----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:26:35 04/06/2018 
-- Design Name: 
-- Module Name:    datapath - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is
    Port ( Nrst : in  STD_LOGIC;
           Nclk : in  STD_LOGIC;
           Ndwr : out  STD_LOGIC_VECTOR (31 downto 0));
end datapath;
architecture Behavioral of datapath is

COMPONENT sumadorcompleto PORT(
          a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           c : out  STD_LOGIC_VECTOR (31 downto 0)
        );
    END COMPONENT;
	 
COMPONENT pc
    PORT(
          Address : in  STD_LOGIC_VECTOR (31 downto 0);
          rst : in  STD_LOGIC;
          clk : in  STD_LOGIC;
          pcout : out  STD_LOGIC_VECTOR (31 downto 0)
        );
    END COMPONENT;
	 
COMPONENT Instructionmemory 
  PORT ( Address : in  STD_LOGIC_VECTOR (5 downto 0);
           rst : in  STD_LOGIC;
           IMout : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	
COMPONENT SEU 
    PORT ( Simm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           Imm32 : out  STD_LOGIC_VECTOR (31 downto 0));
    END COMPONENT;
	 
COMPONENT UC
    PORT ( Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           AluOp : out  STD_LOGIC_VECTOR (5 downto 0));
	END COMPONENT;
	
COMPONENT RF
    PORT(
         rs1 : IN  std_logic_vector(5 downto 0);
         rs2 : IN  std_logic_vector(5 downto 0);
         rd : IN  std_logic_vector(5 downto 0);
         rst : IN  std_logic;
         dwr : IN  std_logic_vector(31 downto 0);
         crs1 : OUT  std_logic_vector(31 downto 0);
         crs2 : OUT  std_logic_vector(31 downto 0)
        );
   END COMPONENT;
	
COMPONENT MUX
    PORT(
         i : IN  std_logic;
         crs2 : IN  std_logic_vector(31 downto 0);
         Imm32 : IN  std_logic_vector(31 downto 0);
         outmux : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	
COMPONENT ALU
    PORT(
         Aluop : IN  std_logic_vector(5 downto 0);
         crs1 : IN  std_logic_vector(31 downto 0);
         outmux : IN  std_logic_vector(31 downto 0);
			Carry: in STD_LOGIC;
         Dwr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
COMPONENT WindowsManager
    PORT(
         rs1 : IN  std_logic_vector(4 downto 0);
         rs2 : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         cwp : IN  std_logic;
         nrs1 : OUT  std_logic_vector(5 downto 0);
         nrs2 : OUT  std_logic_vector(5 downto 0);
         nrd : OUT  std_logic_vector(5 downto 0);
         ncwp : OUT  std_logic
        );
    END COMPONENT;
	 
COMPONENT PSR
    PORT(
         NZVC : IN  std_logic_vector(3 downto 0);
         nCWP : IN  std_logic;
         CLK : IN  std_logic;
         CWP : OUT  std_logic;
         C : OUT    std_logic;
			RST : IN std_logic
        );
    END COMPONENT;	 
 COMPONENT PSR_Modifier
    PORT(
         crs1_31 : IN  std_logic;
         operando2_31 : IN  std_logic;
         aluResult : IN  std_logic_vector(31 downto 0);
         aluop : IN  std_logic_vector(5 downto 0);
         nzvc : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    



signal aux: std_logic_vector(31 downto 0):="00000000000000000000000000000001";
signal auxsumador: std_logic_vector(31 downto 0);
signal auxnpcout: std_logic_vector(31 downto 0);
signal auxpcout: std_logic_vector(31 downto 0);
signal auxoutIM: std_logic_vector(31 downto 0);
signal auxoutSEU: std_logic_vector(31 downto 0);
signal auxoutUC: std_logic_vector(5 downto 0);
signal auxdwr: std_logic_vector(31 downto 0);
signal auxcrs1: std_logic_vector(31 downto 0);
signal auxcrs2: std_logic_vector(31 downto 0);
signal auxoutmux: std_logic_vector(31 downto 0);
signal auxcwp: std_logic;
signal auxncwp: std_logic;
signal auxnrd: std_logic_vector(5 downto 0);
signal auxnrs1: std_logic_vector(5 downto 0);
signal auxnrs2: std_logic_vector(5 downto 0);
signal auxnzvc: std_logic_vector(3 downto 0);
signal auxc: std_logic;





begin


sumador: sumadorcompleto PORT MAP (
			a => aux,
			b => auxnpcout,
			c => auxsumador
			);

npc: pc PORT MAP (
			Address => auxsumador,
			clk => Nclk,
			rst => Nrst,
			pcout => auxnpcout
			);
			
procou: pc PORT MAP (
			Address => auxnpcout,
			clk => Nclk,
			rst => Nrst,
			pcout => auxpcout			
			);
			
IM: Instructionmemory PORT MAP(
			 Address => auxpcout(5 downto 0), 
          rst => Nrst, 
          IMout => auxoutIM
			 );


ExtSgn: SEU PORT MAP (
     Simm13 => auxoutIM(12 downto 0),
     Imm32 => auxoutSEU 
	  );
	  
UnitControl: UC PORT MAP(
		Op => auxoutIM(31 downto 30),
      Op3 => auxoutIM(24 downto 19),
      AluOp => auxoutUC
		);
		
RegF: RF PORT MAP(
		rs1 => auxnrs1,
      rs2 => auxnrs2,
      rd => auxnrd,
      rst => Nrst,
      dwr => auxdwr,
      crs1 => auxcrs1,
      crs2 => auxcrs2
		);
		
Multiplexor: MUX PORT MAP(
         i => auxoutIM(13),
         crs2 => auxcrs2,
         Imm32 => auxoutSEU,
         outmux => auxoutmux
        );
Alu1: ALU PORT MAP(
         Aluop => auxoutUC,
         crs1 => auxcrs1,
         outmux => auxoutmux,
			Carry => auxc,
         Dwr => auxdwr
        );
WM: WindowsManager PORT MAP(
         rs1 => auxoutIM(18 downto 14),
			rs2 => auxoutIM(4 downto 0),
			rd => auxoutIM(29 downto 25),
         op => auxoutIM(31 downto 30),
			op3 => auxoutIM(24 downto 19), 
         cwp => auxcwp,
         nrs1 => auxnrs1, 
         nrs2 => auxnrs2,
         nrd => auxnrd,
         ncwp => auxncwp
        );
		  
PSR1: PSR PORT MAP(
         NZVC => auxnzvc,
         nCWP => auxncwp,
         CLK => Nclk,
         CWP => auxcwp,
			RST => Nrst,
         C => auxc
        );
	 
PSRM: PSR_Modifier PORT MAP(
         crs1_31 => auxcrs1(31),
         operando2_31 =>auxcrs2(31),
         aluResult => auxdwr,
         aluop => auxoutUC,
         nzvc => auxnzvc
        );

		  
Ndwr <= auxdwr;
 
 end Behavioral;