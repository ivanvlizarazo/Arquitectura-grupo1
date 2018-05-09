--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:20:40 04/06/2018
-- Design Name:   
-- Module Name:   C:/Users/utp/Desktop/arquitectura/datapath/datapath_tb.vhd
-- Project Name:  datapath
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: datapath
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
 
ENTITY datapath_tb IS
END datapath_tb;
 
ARCHITECTURE behavior OF datapath_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT datapath
    PORT(
         Nrst : IN  std_logic;
         Nclk : IN  std_logic;
         Ndwr : OUT  std_logic_vector(31 downto 0):= "00000000000000000000000000000000"
        );
    END COMPONENT;
    

   --Inputs
   signal Nrst : std_logic := '0';
   signal Nclk : std_logic := '0';

 	--Outputs
   signal Ndwr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Nclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: datapath PORT MAP (
          Nrst => Nrst,
          Nclk => Nclk,
          Ndwr => Ndwr
        );

   -- Clock process definitions
   Nclk_process :process
   begin 
		Nclk <= '0';
		wait for Nclk_period/2;
		Nclk <= '1';
		wait for Nclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		Nrst <= '1';
      wait for 50 ns;
		
		Nrst <= '0';
      wait for 350 ns;
		
		
		

      wait for Nclk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
