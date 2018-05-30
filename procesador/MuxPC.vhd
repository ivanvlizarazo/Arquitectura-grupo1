library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MuxPC is
    Port ( Call : in  STD_LOGIC_VECTOR (31 downto 0);
           Branch : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PCsource : in  STD_LOGIC_VECTOR (1 downto 0);
           nPC : out  STD_LOGIC_VECTOR (31 downto 0));
end MuxPC;

architecture Behavioral of MuxPC is

begin
Process(Call, Branch, PC, AluResult, PCsource)
begin
if PCsource = "00" then
	nPC <= Call;
elsif PCsource = "01" then
	nPC <= Branch;
elsif PCsource = "10" then
	nPC <= PC;
else
	nPC <= AluResult;
end if;

end process;
end Behavioral;

