
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY ALUTB IS
END ALUTB;
 
ARCHITECTURE behavior OF ALUTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         CRs1 : IN  std_logic_vector(31 downto 0);
         Ope2 : IN  std_logic_vector(31 downto 0);
         carry : IN  std_logic_vector(3 downto 0);
         ALUOP : IN  std_logic_vector(5 downto 0);
         ALUResult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CRs1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Ope2 : std_logic_vector(31 downto 0) := (others => '0');
   signal carry : std_logic_vector(3 downto 0) := (others => '0');
   signal ALUOP : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal ALUResult : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          CRs1 => CRs1,
          Ope2 => Ope2,
          carry => carry,
          ALUOP => ALUOP,
          ALUResult => ALUResult
        );

  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 50 ns;	
	CRS1 <= "00000000000000000000000000000001";
	Ope2 <= "00000000000000000000000000000001";
	
	ALUOP <= "001000";
	carry <= "0001";
	
	wait for 50 ns;
	
	ALUOP <= "011000";
	carry <= "0011";
	
	wait for 50 ns;
	
	CRS1 <= "00000000000000000000000000000010";
	Ope2 <= "00000000000000000000000000000001";
	ALUOP <= "011000"; --ADDxcc
	
	carry <= "1011";
	
	wait for 50 ns;
	
	ALUOP <= "011100"; --SUBxcc
	carry<= "1100";
      
      -- insert stimulus here 

      wait;
   end process;

END;
