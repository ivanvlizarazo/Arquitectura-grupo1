library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MuxRd is
    Port ( RD : in  STD_LOGIC_VECTOR (5 downto 0);
           RFdest : in  STD_LOGIC;
           nRD : out  STD_LOGIC_VECTOR (5 downto 0));
end MuxRd;

architecture Behavioral of MuxRd is
signal Rd15: std_logic_vector(5 downto 0):="001111";

begin
process(RD, RFdest)
begin

if RFdest = '0' then
	nRD <= RD;
else
	nRD <= Rd15;
end if;

end process;
end Behavioral;

