library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity ControlUnit is
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
end ControlUnit;

architecture Behavioral of ControlUnit is

begin
process(OP, OP3)
begin
		case (OP) is
			when "00" => --BRANCH
				RFDEST <= '0';
				WE <= '0';
				WRENMEM <= '0';
				RFSRC <= "01";
				ALUOP <= "000000";
				if (  (cond = "1000") --BA
					or ((cond = "1001") and (not icc(2) = '1')) --BNE
					or ((cond = "0001") and (icc(2) = '1')) --BE
					or ((cond = "1010") and (not(icc(2) or (icc(3) xor icc(1))) = '1')) --BG
					or ((cond = "0010") and ('1' = (icc(2) or (icc(3) xor icc(1))))) --BLE
					or ((cond = "1011") and ('1' = not(icc(3) xor icc(1)))) --BGE
					or ((cond = "0011") and ('1' = (icc(3) xor icc(1)))) --BL
					or ((cond = "1100") and ('1' = not(icc(0) or icc(2)))) --BGU
					or ((cond = "0100") and ('1' = (icc(0) or icc(2)))) --BLEU
					or ((cond = "1101") and ('1' = (not icc(0)))) --BCC
					or ((cond = "0101") and ('1' = icc(0))) --BCS
					or ((cond = "1110") and ('1' = (not icc(3)))) --BPOS
					or ((cond = "0110") and ('1' = icc(3))) --BNEG
					or ((cond = "1111") and ('1' = (not icc(1)))) --BVC
					or ((cond = "0111") and (icc(1) = '1')) --BVS
					) then
					PCSRC <= "01";
				else
					PCSRC <= "10";
				end if;
					
					
			when "01" => --CALL
				RFSRC <= "10";
				WE <= '1';
				RFDEST <= '1';
				PCSRC <= "00";
				WRENMEM <= '0';
				ALUOP <= "000000";				
				
			when "10" => --ARITHMETIC LOGIC
				RFDEST <= '0';
				WE <= '1';
				WRENMEM <= '0';
				RFSRC <= "01";
				PCSRC <= "10";
				case (OP3) is
					when "000000" => ALUOP <= "000000"; --ADD
					when "010000" => ALUOP <= "010000"; --ADDcc
					when "001000" => ALUOP <= "001000"; --ADDx
					when "011000" => ALUOP <= "011000"; --ADDxcc
					when "000100" => ALUOP <= "000100"; --SUB
					when "010100" => ALUOP <= "010100"; --SUBcc
					when "001100" => ALUOP <= "001100"; --SUBx
					when "011100" => ALUOP <= "011100"; --SUBxcc	
					
					when "000001" => ALUOP <= "000001"; --AND
					when "010001" => ALUOP <= "010001"; --ANDcc
					when "000101" => ALUOP <= "000101"; --ANDN
					when "010101" => ALUOP <= "010101"; --ANDNcc
					when "000010" => ALUOP <= "000010"; --OR
					when "010010" => ALUOP <= "010010"; --ORcc
					when "000110" => ALUOP <= "000110"; --ORN
					when "010110" => ALUOP <= "010110"; --ORNcc
					when "000011" => ALUOP <= "000011"; --XOR
					when "010011" => ALUOP <= "010011"; --XORcc
					when "000111" => ALUOP <= "000111"; --XNOR
					when "010111" => ALUOP <= "010111"; --XNORcc
					
					when "100101" => ALUOP <= "100101"; --SLL
					when "100110" => ALUOP <= "100110"; --SRL
					when "111100" => ALUOP <= "000000"; --SAVE
					when "111101" => ALUOP <= "000000"; --RESTORE
					when "111000" => --JUMP
						PCSRC <= "11";
						ALUOP <= "000000"; 
					when others => ALUOP <= "111111";
				end case;
			
			when "11" => --ACCESS TO MEMORY
				RFDEST <= '0';
				RFSRC <= "00";
				PCSRC <= "10";
				ALUOP <= "000000";
				case (OP3) is 
					when "000000" => --LOAD
						WE <= '1';
						WRENMEM <= '0';
					when "000100" => --STORE
						WE <= '0';
						WRENMEM <= '1';
					when others => ALUOP <= "111111";
				end case;
			when others => ALUOP <= "111111";
		end case;
				
end process;
end Behavioral;
