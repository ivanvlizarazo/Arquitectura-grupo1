--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:01:26 04/06/2018
-- Design Name:   
-- Module Name:   E:/arquitecturaclase/datapath/datapath/Instructionmemory_tb.vhd
-- Project Name:  datapath
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: instructionMemory
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
 
ENTITY Instructionmemory_tb IS
END Instructionmemory_tb;
 
ARCHITECTURE behavior OF Instructionmemory_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT instructionMemory
    PORT(
         address : IN  std_logic_vector(5 downto 0);
         rst : IN  std_logic;
         IMout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal address : std_logic_vector(5 downto 0) := (others => '0');
   signal rst : std_logic := '0';

 	--Outputs
   signal IMout : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: instructionMemory PORT MAP (
          address => address,
          rst => rst,
          IMout => IMout
        );

   -- Clock process definitions

   -- Stimulus process
   stim_proc: process
   begin
	   address <= "000000";
		rst <= '0';
      wait for 20 ns;

		address <= "000001";
		rst <= '1';
      wait for 20 ns;

		address <= "000010";
		rst <= '0';
      wait for 20 ns;
		
		address <= "111111";
		rst <= '0';
      wait for 20 ns;	


      -- insert stimulus here 
 
      wait;
   end process;

END;
