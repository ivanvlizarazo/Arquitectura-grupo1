--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:23:51 05/09/2018
-- Design Name:   
-- Module Name:   C:/Users/utp/Desktop/procesador/procesador/PSR_MODIFIER_TB.vhd
-- Project Name:  procesador
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PSR_Modifier
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
 
ENTITY PSR_MODIFIER_TB IS
END PSR_MODIFIER_TB;
 
ARCHITECTURE behavior OF PSR_MODIFIER_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR_Modifier
    PORT(
         crs1_31 : IN  std_logic;
         operando2_31 : IN  std_logic;
         aluResult : IN  std_logic_vector(31 downto 0);
         aluop : IN  std_logic_vector(5 downto 0);
         nzvc : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal crs1_31 : std_logic := '0';
   signal operando2_31 : std_logic := '0';
   signal aluResult : std_logic_vector(31 downto 0) := (others => '0');
   signal aluop : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal nzvc : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR_Modifier PORT MAP (
          crs1_31 => crs1_31,
          operando2_31 => operando2_31,
          aluResult => aluResult,
          aluop => aluop,
          nzvc => nzvc
        );

   -- Stimulus process
   stim_proc: process
   begin		
	
			crs1_31 <= '0';
         operando2_31 <= '0';
         aluResult <= "10000000000000000000000000000000";
         aluop <= "010000";
      -- hold reset state for 100 ns.
      wait for 50 ns;
			crs1_31 <= '0';
         operando2_31 <= '0';
         aluResult <= "00000000000000000000000000000001";
         aluop <= "010000";
      -- hold reset state for 100 ns.
      wait for 50 ns;
			crs1_31 <= '0';
         operando2_31 <= '0';
         aluResult <= "00000000000000000000000000000000";
         aluop <= "010000";
      -- hold reset state for 100 ns.
      wait for 50 ns;	

      

      -- insert stimulus here 

      wait;
   end process;

END;
