----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:43:40 04/13/2018 
-- Design Name: 
-- Module Name:    MUX - Behavioral 
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

entity MUX is
    Port ( i : in  STD_LOGIC;
           crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Imm32 : in  STD_LOGIC_VECTOR (31 downto 0);
           outmux : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX;

architecture Behavioral of MUX is

begin

process (i, crs2, Imm32)

  begin
    
    if(i = '1') then
	   outmux <= Imm32;
		
		else 
		  outmux <= crs2;
		  
	 end if;
	 
end process;
	
	 


end Behavioral;

