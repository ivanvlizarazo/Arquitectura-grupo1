----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:26:35 04/06/2018 
-- Design Name: 
-- Module Name:    datapath - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is
    Port ( Nrst : in  STD_LOGIC;
           Nclk : in  STD_LOGIC;
           Npcout : out  STD_LOGIC_VECTOR (31 downto 0));
end datapath;
architecture Behavioral of datapath is

COMPONENT sumadorcompleto PORT(
          a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           c : out  STD_LOGIC_VECTOR (31 downto 0)
        );
    END COMPONENT;
	 
COMPONENT pc
    PORT(
          Address : in  STD_LOGIC_VECTOR (31 downto 0);
          rst : in  STD_LOGIC;
          clk : in  STD_LOGIC;
          pcout : out  STD_LOGIC_VECTOR (31 downto 0)
        );
    END COMPONENT;
	 



signal aux: std_logic_vector(31 downto 0):="00000000000000000000000000000100";
signal auxsumador: std_logic_vector(31 downto 0);
signal auxpcout: std_logic_vector(31 downto 0);

begin


sumador: sumadorcompleto PORT MAP (
			a => aux,
			b => auxpcout,
			c => auxsumador
			);

npc: pc PORT MAP (
			Address => auxsumador,
			clk => Nclk,
			rst => Nrst,
			pcout => auxpcout
			);
			
procou: pc PORT MAP (
			Address => auxpcout,
			clk => Nclk,
			rst => Nrst,
			pcout => Npcout
			);
			



end Behavioral;

