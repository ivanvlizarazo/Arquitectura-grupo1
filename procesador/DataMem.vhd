library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_misc.all;

entity DataMem is
    Port ( WrEna : in  STD_LOGIC;
           cRD : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult  : in  STD_LOGIC_VECTOR (31 downto 0);
			  rst: in STD_LOGIC;
           DataToMem : out  STD_LOGIC_VECTOR (31 downto 0));
end DataMem;

architecture Behavioral of DataMem is

	type Memory Is array (0 to 63) of bit_vector(31 DOWNTO 0);
	signal RAM : Memory := (others => x"00000000");
	signal AuxDir: STD_LOGIC_VECTOR (31 downto 0):= "00000000000000000000000000000000";
	
begin
process(WrEna,cRD,AluResult(5 downto 0),rst)
begin 
AuxDir <= AluResult;


if(WrEna = '1')then
	if or_reduce(AuxDir xor AluResult) = '1' then
		RAM(CONV_INTEGER(AluResult(5 downto 0))) <= to_bitvector(cRD);
	end if;
	DataToMem <= cRD;
else
	DataToMem <= to_stdlogicvector(RAM(CONV_INTEGER(AluResult(5 downto 0))));
end if;

if rst= '1' then 
	RAM <= (others => x"00000000");
end if;
end process;
end Behavioral;

