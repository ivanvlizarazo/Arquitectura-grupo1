library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity PSR is
    Port ( NZVC : in  STD_LOGIC_VECTOR (3 downto 0):="0000";
			  nCWP : in STD_LOGIC_VECTOR (4 downto 0):="00000";
			  CWP : out STD_LOGIC_VECTOR (4 downto 0);
           C : out  STD_LOGIC_VECTOR (3 downto 0);
			  CLK: in STD_LOGIC);
end PSR;

architecture Behavioral of PSR is
signal Psr32 : STD_LOGIC_VECTOR(31 downto 0):="00000000000000000000000000000000";
begin
process(CLK) 
begin

if(rising_edge(CLK)) then
	Psr32(23 downto 20) <= NZVC;
	Psr32(4 downto 0) <= nCWP;
	
	C <= NZVC;
	CWP <= nCWP;
	
end if;

end process;
end Behavioral;

