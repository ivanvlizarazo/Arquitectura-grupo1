--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:24:57 04/13/2018
-- Design Name:   
-- Module Name:   E:/arquitecturaclase/datapath/datapath/ALU_tb.vhd
-- Project Name:  datapath
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         Aluop : IN  std_logic_vector(5 downto 0);
         crs1 : IN  std_logic_vector(31 downto 0);
         outmux : IN  std_logic_vector(31 downto 0);
         Dwr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Aluop : std_logic_vector(5 downto 0) := (others => '0');
   signal crs1 : std_logic_vector(31 downto 0) := (others => '0');
   signal outmux : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Dwr : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          Aluop => Aluop,
          crs1 => crs1,
          outmux => outmux,
          Dwr => Dwr
        );

   
 

   -- Stimulus process
   stim_proc: process
   begin		
      Aluop <= "000000";
		crs1 <= "00000000000000000000000000000001";
		outmux <= "00000000000000000000000000000011";
      wait for 20 ns;	
		
		Aluop <= "000100";
		crs1 <= "00000000000000000000000000000001";
		outmux <= "00000000000000000000000000000011";
      wait for 20 ns;	
		
		Aluop <= "000010";
		crs1 <= "00000000000000000000000000000001";
		outmux <= "00000000000000000000000000000011";
      wait for 20 ns;	
		
		Aluop <= "000110";
		crs1 <= "00000000000000000000000000000001";
		outmux <= "00000000000000000000000000000011";
      wait for 20 ns;	
		
		Aluop <= "000011";
		crs1 <= "00000000000000000000000000000001";
		outmux <= "00000000000000000000000000000011";
      wait for 20 ns;	
		
		Aluop <= "000111";
		crs1 <= "00000000000000000000000000000001";
		outmux <= "00000000000000000000000000000011";
      wait for 20 ns;	
		
		Aluop <= "000001";
		crs1 <= "00000000000000000000000000000001";
		outmux <= "00000000000000000000000000000011";
      wait for 20 ns;	
		
		Aluop <= "000101";
		crs1 <= "00000000000000000000000000000001";
		outmux <= "00000000000000000000000000000011";
      wait for 20 ns;	

      

     

      wait;
   end process;

END;
