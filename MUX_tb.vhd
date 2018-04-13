--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:47:56 04/13/2018
-- Design Name:   
-- Module Name:   E:/arquitecturaclase/datapath/datapath/MUX_tb.vhd
-- Project Name:  datapath
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX
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
 
ENTITY MUX_tb IS
END MUX_tb;
 
ARCHITECTURE behavior OF MUX_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX
    PORT(
         i : IN  std_logic;
         crs2 : IN  std_logic_vector(31 downto 0);
         Imm32 : IN  std_logic_vector(31 downto 0);
         outmux : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i : std_logic := '0';
   signal crs2 : std_logic_vector(31 downto 0) := (others => '0');
   signal Imm32 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal outmux : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX PORT MAP (
          i => i,
          crs2 => crs2,
          Imm32 => Imm32,
          outmux => outmux
        );

  
 

   -- Stimulus process
   stim_proc: process
   begin		
      i <= '1';
		crs2 <= "00000000000000000000000000000001";
		Imm32 <= "00000000000000000000000000000011";
      wait for 20 ns;	
		
		i <= '0';
		crs2 <= "00000000000000000000000000000001";
		Imm32 <= "00000000000000000000000000000011";
      wait for 20 ns;


       

      wait;
   end process;

END;
