----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:53:44 04/06/2018 
-- Design Name: 
-- Module Name:    Instructionmemory - Behavioral 
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

entity Instructionmemory is
    Port ( Address : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           IMout : out  STD_LOGIC_VECTOR (31 downto 0));
end Instructionmemory;

architecture Behavioral of Instructionmemory is

begin


end Behavioral;

