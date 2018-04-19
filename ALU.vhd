----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:11:03 04/13/2018 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( Aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           crs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           outmux : in  STD_LOGIC_VECTOR (31 downto 0);
           Dwr : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

	process (Aluop, crs1, outmux)
		
		begin
		
			case (Aluop) is
			
				when "000000" => -- add
				
					Dwr <= crs1 + outmux;
					
				when "000100" => -- sub
				
					Dwr <= crs1 - outmux;
					
				when "000010" => --or
				
					Dwr <= crs1 or outmux;
					
				when "000110" => -- orn
				
					Dwr <= crs1 or (not outmux);
					
				when "000011" => -- xor
				
					Dwr <= crs1 xor outmux;
					
				when "000111" => -- xnor
				
					Dwr <= crs1 xnor outmux;
					
				when "000001" => -- and
				
					Dwr <= crs1 and outmux;
					
				when "000101" => -- andn
				
					Dwr <= crs1 and (not outmux);
					
				when others =>
				
					Dwr <= (others => '0');
					
			end case;
	end process;
				


end Behavioral;

