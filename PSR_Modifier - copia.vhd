library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity PSR_Modifier is
    Port ( crs1_31 : in  STD_LOGIC;
           operando2_31 : in  STD_LOGIC;
           aluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
end PSR_Modifier;

architecture Behavioral of PSR_Modifier is

begin
	
	process(crs1_31, operando2_31, aluResult, aluop)
		begin
			
			if(aluop = "010000") or (aluop = "011000") then ------ ADDcc , ADDXcc
			
				nzvc(3) <= aluResult(31);
				
				if (aluResult = "00000000000000000000000000000000") then
					
					nzvc(2) <= '1';
					
				else nzvc(2) <= '0';
				end if;
				
				nzvc(1) <= (crs1_31 and operando2_31 and (not aluResult(31))) or ((crs1_31) and  (not operando2_31) and aluResult(31));
			   nzvc(0) <= (crs1_31 and operando2_31) or ((not aluResult(31)) and (crs1_31 or operando2_31));
			end if;
			
			
			if(aluop = "010100") or (aluop = "011100") then ----------- SUBcc , SUBXcc
			
			  nzvc(3) <= aluResult(31);
			  
			  	if (aluResult = "00000000000000000000000000000000") then
					
					nzvc(2) <= '1';
					
				else nzvc(2) <= '0';				
				end if;
				
			nzvc(1) <= (crs1_31 and (not Operando2_31) and (not aluResult(31))) or ( (not crs1_31) and Operando2_31 and aluResult(31) );
			nzvc(0) <= ( (not crs1_31) and Operando2_31) or (aluResult(31) and (( not crs1_31 or Operando2_31)));

       end if;
		end process;

end Behavioral;

