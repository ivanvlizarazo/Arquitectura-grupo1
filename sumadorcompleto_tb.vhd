--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:19:33 04/04/2018
-- Design Name:   
-- Module Name:   C:/Users/utp/Desktop/arquitectura/sumadorcompleto/sumadorcompleto_tb.vhd
-- Project Name:  sumadorcompleto
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sumadorcompleto
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
 
ENTITY sumadorcompleto_tb IS
END sumadorcompleto_tb;
 
ARCHITECTURE behavior OF sumadorcompleto_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sumadorcompleto
    PORT(
         a : IN  std_logic_vector(31 downto 0);
         b : IN  std_logic_vector(31 downto 0);
         c : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(31 downto 0) := (others => '0');
   signal b : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal c : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sumadorcompleto PORT MAP (
          a => a,
          b => b,
          c => c
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		a <= "00000000000000000000000000000011";
		b <= "00000000000000000000000000000011";
      wait for 20 ns;
		
		a <= "00000000000000000000000000000010";
		b <= "00000000000000000000000000000011";
		wait for 20 ns;
		

    

      -- insert stimulus here 

      wait;
   end process;

END;
