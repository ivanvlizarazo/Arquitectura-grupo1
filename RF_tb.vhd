--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:34:27 04/06/2018
-- Design Name:   
-- Module Name:   E:/arquitecturaclase/datapath/datapath/RF_tb.vhd
-- Project Name:  datapath
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
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
 
ENTITY RF_tb IS
END RF_tb;
 
ARCHITECTURE behavior OF RF_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         rs1 : IN  std_logic_vector(4 downto 0);
         rs2 : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         rst : IN  std_logic;
         dwr : IN  std_logic_vector(31 downto 0);
         crs1 : OUT  std_logic_vector(31 downto 0);
         crs2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rs1 : std_logic_vector(4 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(4 downto 0) := (others => '0');
   signal rd : std_logic_vector(4 downto 0) := (others => '0');
   signal rst : std_logic := '0';
   signal dwr : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal crs1 : std_logic_vector(31 downto 0);
   signal crs2 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          rst => rst,
          dwr => dwr,
          crs1 => crs1,
          crs2 => crs2
        );

 

   -- Stimulus process
   stim_proc: process
   begin

		
		rs1 <= "00000";
		rs2 <= "00000";
		rd  <= "00001";
		rst <= '0';
		dwr <= "00000000000000000000000000000001";
      -- hold reset state for 100 ns.
      wait for 20 ns;

		rs1 <= "00000";
		rs2 <= "00000";
		rd  <= "00010";
		rst <= '0';
		dwr <= "00000000000000000000000000000101";
      -- hold reset state for 100 ns.
      wait for 20 ns;

		rs1 <= "00000";
		rs2 <= "00000";
		rd  <= "00011";
		rst <= '0';
		dwr <= "00000000000000000000000000000010";
      -- hold reset state for 100 ns.
      wait for 20 ns;

		rs1 <= "00001";
		rs2 <= "00010";
		rd  <= "01000";
		rst <= '0';
		dwr <= "00000000000000000000000000010001";
      -- hold reset state for 100 ns.
      wait for 20 ns;

		rs1 <= "00011";
		rs2 <= "00001";
		rd  <= "01000";
		rst <= '0';
		dwr <= "00000000000000000000000000000001";
      -- hold reset state for 100 ns.
      wait for 20 ns;	

     

      wait;
   end process;

END;
