----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:29:53 05/04/2018 
-- Design Name: 
-- Module Name:    PSR - Behavioral 
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

entity PSR is
    Port ( NZVC : in  STD_LOGIC_VECTOR (3 downto 0):="0000";
           nCWP : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           CWP : out  STD_LOGIC;
           C : out  STD_LOGIC;
			  RST: 	in STD_LOGIC);

end PSR;


architecture Behavioral of PSR is
---signal AUX : STD_LOGIC_VECTOR(3 downto 0):="0000";
begin
process(CLK) 
begin


	if (RST = '1') then
		C <= '0';
		CWP <= '0';
	else
		if(rising_edge(CLK)) then
			C <= NZVC(0);
			CWP <= nCWP;
	end if;
	
	
end if;

end process;
end Behavioral;

