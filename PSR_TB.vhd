--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:32:22 05/04/2018
-- Design Name:   
-- Module Name:   C:/Users/utp/Desktop/Procesador2/procesador/PSR_TB.vhd
-- Project Name:  procesador
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PSR
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PSR_TB IS
END PSR_TB;
 
ARCHITECTURE behavior OF PSR_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
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
    

   --Inputs
   signal NZVC : std_logic_vector(3 downto 0) := (others => '0');
   signal nCWP : std_logic := '0';
   signal CLK : std_logic := '0';
	signal RST : std_logic := '0';

 	--Outputs
   signal CWP : std_logic;
   signal C : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR PORT MAP (
          NZVC => NZVC,
          nCWP => nCWP,
          CLK => CLK,
          CWP => CWP,
			 RST => RST,
          C => C
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		NZVC <= "0100";
		nCWP <= '1';
		RST <= '0';
      wait for 20		ns;
		
		NZVC <= "0101";
		nCWP <= '0';
		RST <= '0';
      wait for 20		ns;		

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
