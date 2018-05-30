library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PSRModifier is
    Port ( ALUResult : in  STD_LOGIC_VECTOR (31 downto 0);
           Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           NZVC : out  STD_LOGIC_VECTOR (3 downto 0));
end PSRModifier;

architecture arq of PSRModifier is
signal NZVCaux: std_logic_vector(3 downto 0):="0000";

begin
	process(Op1, Op2, ALUOP, ALUResult, NZVCaux)
		begin
		--ADDcc, ADDxcc
		if (ALUOP = "010000" or ALUOP = "011000") then
			NZVCaux(3) <= ALUResult(31);
			if (ALUResult = "00000000000000000000000000000000") then
				NZVCaux(2) <= '1';
			else
				NZVCaux(2) <= '0';
			end if;
			NZVCaux(1) <= (Op1(31) and Op2(31) and (not ALUResult(31))) or ((not Op1(31)) and (not Op2(31)) and ALUResult(31));
			NZVCaux(0) <= (Op1(31) and Op2(31)) or ((not ALUResult(31)) and (Op1(31) or Op2(31)));
		end if;
		
		--SUBcc, SUBxcc
		if (ALUOP = "010100" or ALUOP = "011100") then
			NZVCaux(3) <= ALUResult(31);
			if (ALUResult = "00000000000000000000000000000000") then
				NZVCaux(2) <= '1';
			else
				NZVCaux(2) <= '0';
			end if;
			NZVCaux(1) <= (Op1(31) and (not Op2(31)) and (not ALUResult(31))) or ((not Op1(31)) and Op2(31) and ALUResult(31));
			NZVCaux(0) <= ((not Op1(31)) and Op2(31)) or (ALUResult(31) and ((not Op1(31)) or Op2(31)));	
		end if;
		
		--ANDcc, ANDNcc, ORcc, ORNcc, XORcc, XNORcc
		if (ALUOP = "010001" or ALUOP = "010101" or ALUOP = "010010" 
			 or ALUOP = "010110" or ALUOP ="010011" or ALUOP = "010111") then
			
			NZVCaux(3) <= ALUResult(31);
			if (ALUResult = "00000000000000000000000000000000") then
				NZVCaux(2) <= '1';
			else
				NZVCaux(2) <= '0';
			end if;
			NZVCaux(1) <= '0';
			NZVCaux(0) <= '0';
		end if;
		NZVC <= NZVCaux;
	end process;

end arq;