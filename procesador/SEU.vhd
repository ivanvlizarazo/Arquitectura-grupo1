library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity SEU is
    Port ( imm : in  STD_LOGIC_VECTOR (12 downto 0);
           immExt : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU;

architecture Behavioral of SEU is
signal aux: STD_LOGIC_VECTOR (18 downto 0);

begin
	process(imm)
	begin
		if (imm(12) = '1') then
			aux <= "1111111111111111111";
		else
			aux <= "0000000000000000000";
		end if;
		
	end process;
	immExt <= aux & imm;
end Behavioral;

