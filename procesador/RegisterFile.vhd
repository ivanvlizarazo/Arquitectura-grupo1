library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RegisterFile is
    Port ( rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
           rst : in  STD_LOGIC;
			  WE : in STD_LOGIC;
           dwr : in  STD_LOGIC_VECTOR (31 downto 0);
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
			  crd : out STD_LOGIC_VECTOR (31 downto 0);
           crs2 : out  STD_LOGIC_VECTOR (31 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is
type RAM_type is array(39 downto 0) of bit_vector(31 downto 0);
	signal Ram : RAM_type:= (others => x"00000000");
begin
process(rs1,rs2,rd,dwr,rst)
begin

crs1 <= to_stdlogicvector(Ram(conv_integer(rs1)));
crs2 <= to_stdlogicvector(Ram(conv_integer(rs2)));
if rd /= "00000" then
	if WE = '1' then
		Ram(conv_integer(rd)) <= to_bitvector(dwr);
		crd <= dwr;
	else
		crd <= to_stdlogicvector(Ram(conv_integer(rd)));
	end if;
end if;

if rst = '1' then
	Ram <= (others => "00000000000000000000000000000000");
end if;

end process;
end Behavioral;
