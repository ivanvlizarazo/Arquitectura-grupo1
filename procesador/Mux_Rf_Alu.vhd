library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Mux_Rf_Alu is
    Port ( Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Imm32 : in  STD_LOGIC_VECTOR (31 downto 0);
			  l3 : in STD_LOGIC;
           Crs2Out : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux_Rf_Alu;

architecture Behavioral of Mux_Rf_Alu is

begin
Crs2Out <= Imm32 when (l3 = '1') else Crs2;

end Behavioral;

