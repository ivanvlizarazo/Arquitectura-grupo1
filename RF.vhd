----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:21:55 04/06/2018 
-- Design Name: 
-- Module Name:    RF - Behavioral 
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
use IEEE.std_logic_arith.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RF is
    Port ( rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
			  rst : in  STD_LOGIC;
           dwr : in  STD_LOGIC_VECTOR (31 downto 0);
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           crs2 : out  STD_LOGIC_VECTOR (31 downto 0));
end RF;

architecture Behavioral of RF is
	type ram_type is array (0 to 39) of std_logic_vector (31 downto 0);
	signal RAM: ram_type:= ( others => "00000000000000000000000000000000");

begin

	 RAM(0)<="00000000000000000000000000000000" ;
    process (rs1, rs2, rd, dwr, rst,RAM)
		begin
		if  rst = '1'  then
		RAM <=( others => "00000000000000000000000000000000");
			crs1 <= "00000000000000000000000000000000" ;
		   crs2 <="00000000000000000000000000000000" ;
		else 
		  crs1 <= RAM(conv_integer(rs1)) ;
		  crs2 <= RAM(conv_integer(rs2))  ;
		  if rd /= "00000" then
				RAM(conv_integer(rd)) <= dwr;
			end if;
		end if;
		
    end process;


end Behavioral;

