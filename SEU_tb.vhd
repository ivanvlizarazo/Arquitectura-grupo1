--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:34:38 04/13/2018
-- Design Name:   
-- Module Name:   E:/arquitecturaclase/datapath/datapath/SEU_tb.vhd
-- Project Name:  datapath
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SEU
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
 
ENTITY SEU_tb IS
END SEU_tb;
 
ARCHITECTURE behavior OF SEU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SEU
    PORT(
         Simm13 : IN  std_logic_vector(12 downto 0);
         Imm32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Simm13 : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal Imm32 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SEU PORT MAP (
          Simm13 => Simm13,
          Imm32 => Imm32
        );

  
 

   -- Stimulus process
   stim_proc: process
   begin		
		Simm13 <= "0000000000011";
      wait for 30 ns;
		
		Simm13 <= "1000000000011";
      wait for 30 ns;		

     

      -- insert stimulus here 

      wait;
   end process;

END;
