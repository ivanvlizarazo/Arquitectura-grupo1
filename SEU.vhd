----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:25:16 04/13/2018 
-- Design Name: 
-- Module Name:    SEU - Behavioral 
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

entity SEU is
    Port ( Simm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           Imm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU;

architecture Behavioral of SEU is

	

begin

process (Simm13)
	begin
		if(Simm13(12) = '0') then
			Imm32 <= "0000000000000000000" & Simm13;
		else
			Imm32 <= "1111111111111111111" & Simm13;
		end if;
end process;
	
			
	

end Behavioral;

