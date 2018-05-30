library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity MuxDataMemory is
    Port ( DatatoMEM : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
			  RFsource : in STD_LOGIC_VECTOR (1 downto 0);
           DataToReg : out  STD_LOGIC_VECTOR (31 downto 0));
end MuxDataMemory;

architecture Behavioral of MuxDataMemory is
signal AuxPC: STD_LOGIC_VECTOR (31 downto 0);
	
begin
Process(DatatoMEM, AluResult, PC, RFsource)
begin
if RFsource = "00" then
	DataToReg <= DatatoMEM;
elsif RFsource = "01" then
	DataToReg <= AluResult;
elsif RFsource = "10" then
	DataToReg <= AuxPC;
end if;

AuxPC <= PC;

end process;

end Behavioral;

