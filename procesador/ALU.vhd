library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity ALU is
    Port ( CRs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Ope2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  carry: in std_logic_vector( 3 downto 0);
           ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUResult : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

	process(ALUOP, CRs1, Ope2)
		begin 
			case ALUOP is
				when "000000" => ALUResult <= std_logic_vector((signed(CRs1)) + (signed(Ope2))); --ADD
				when "000100" => ALUResult <= std_logic_vector((signed(CRs1)) - (signed(Ope2))); -- SUBB
				when "100101" => ALUResult <= std_logic_vector(shift_left(unsigned(CRs1), to_integer(unsigned(Ope2)))); -- SLL
				when "100110" => ALUResult <= std_logic_vector(shift_right(unsigned(CRs1), to_integer(unsigned(Ope2)))); -- SRL
				when "000001" => ALUResult <= std_logic_vector((signed(CRs1)) and (signed(Ope2))); --and
				when "000101" => ALUResult <= std_logic_vector((signed(CRs1)) and not((signed(Ope2)))); --andn
				when "000010" => ALUResult <= std_logic_vector((signed(CRs1)) OR (signed(Ope2))); --or 
				when "000110" => ALUResult <= std_logic_vector((signed(CRs1)) OR NOT((signed(Ope2))));  -- orn
				when "000011" => ALUResult <= std_logic_vector((signed(CRs1)) xor (signed(Ope2)));  -- XOR
				when "000111" => ALUResult <= std_logic_vector((signed(CRs1)) xnor (signed(Ope2))); --XNOR
				--Conditional code
				when "010000" => ALUResult <= std_logic_vector((signed(CRs1)) + (signed(Ope2))); --ADDcc
				when "010100" => ALUResult <= std_logic_vector((signed(CRs1)) - (signed(Ope2))); -- SUBcc
				when "010001" => ALUResult <= std_logic_vector((signed(CRs1)) and (signed(Ope2))); --andcc
				when "010101" => ALUResult <= std_logic_vector((signed(CRs1)) and not((signed(Ope2)))); --andncc
				when "010010" => ALUResult <= std_logic_vector((signed(CRs1)) OR (signed(Ope2))); --orcc
				when "010110" => ALUResult <= std_logic_vector((signed(CRs1)) OR NOT((signed(Ope2))));  -- orncc
				when "010011" => ALUResult <= std_logic_vector((signed(CRs1)) xor (signed(Ope2)));  -- XORcc
				when "010111" => ALUResult <= std_logic_vector((signed(CRs1)) xnor (signed(Ope2))); --XNORcc
				--Save y Restore
				when "111100" => ALUResult <= std_logic_vector((signed(CRs1)) + (signed(Ope2))); --SAVE temporal
				when "111101" => ALUResult <= std_logic_vector((signed(CRs1)) + (signed(Ope2))); --restore temporal
				
				when "001000" =>  --addx
					case carry(0) is 
						when '1' => ALUResult <= std_logic_vector((signed(CRs1)) + (signed(Ope2)) + "0001");
						when '0' => ALUResult <= std_logic_vector((signed(CRs1)) + (signed(Ope2)));
						when others => end case;
				when "011000" => --addxcc
					case carry(0) is 
						when '1' => ALUResult <= std_logic_vector((signed(CRs1)) + (signed(Ope2)) + "0001");
						when '0' => ALUResult <= std_logic_vector((signed(CRs1)) + (signed(Ope2)));
						when others => end case;
						
				when "001100" => --subx
					case carry(0) is 
						when '1' => ALUResult <= std_logic_vector((signed(CRs1)) - (signed(Ope2)) - "0001");
						when '0' => ALUResult <= std_logic_vector((signed(CRs1)) - (signed(Ope2)));
						when others => end case;
						
				when "011100" => --subxcc
					case carry(0) is 
						when '1' => ALUResult <= std_logic_vector((signed(CRs1)) - (signed(Ope2)) - "0001");
						when '0' => ALUResult <= std_logic_vector((signed(CRs1)) - (signed(Ope2)));
						when others => end case;
			
				
				
				when others => end case;
	end process;
end Behavioral;
