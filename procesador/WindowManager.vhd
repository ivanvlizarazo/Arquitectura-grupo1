library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use ieee.numeric_std.all;


entity WindowManager is
    Port ( RS1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           CWP : in  STD_LOGIC_VECTOR (4 downto 0);
           nCWP : out  STD_LOGIC_VECTOR (4 downto 0);
           nRS1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nRS2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nRD : out  STD_LOGIC_VECTOR (5 downto 0));
end WindowManager;

architecture Behavioral of WindowManager is
type RAM_type is array(31 downto 0) of bit_vector(31 downto 0);
	signal Ram : RAM_type;

signal wind: std_logic_vector(4 downto 0):="00000";

begin
process(CWP,RS1,RS2,RD,OP3,wind)
begin
	if(RS1 >= 24 and RS1 <= 31) then
		nRS1 <= 	std_logic_vector(to_unsigned(conv_integer(RS1) - (conv_integer(CWP)*16),6));
	end if;
	if(RS1 >= 8 and RS1 <= 23) then
		nRS1 <= 	std_logic_vector(to_unsigned(conv_integer(RS1) + (conv_integer(CWP)*16),6));
	end if;
	if(RS1 >= 0 and RS1 <= 7) then
		nRS1 <= 	'0' & RS1;
	end if;
	
	if(RS2 >= 24 and RS2 <= 31) then
		nRS2 <= 	std_logic_vector(to_unsigned(conv_integer(RS2) - (conv_integer(CWP)*16),6));
	end if;
	if(RS2 >= 8 and RS2 <= 23) then
		nRS2 <= 	std_logic_vector(to_unsigned(conv_integer(RS2) + (conv_integer(CWP)*16),6));
	end if;
	if(RS2 >= 0 and RS2 <= 7) then
		nRS2 <= 	'0' & RS2;
	end if;
	
	if(RD >= 24 and RD <= 31) then
		nRD <= 	std_logic_vector(to_unsigned(conv_integer(RD) - (conv_integer(CWP)*16),6));
	end if;
	if(RD >= 8 and RD <= 23) then
		nRD <= 	std_logic_vector(to_unsigned(conv_integer(RD) + (conv_integer(CWP)*16),6));
	end if;
	if(RS1 >= 0 and RD <= 7) then
		nRD <= 	'0' & RD;
	end if;
	
	
	
	if(OP = "10")and(OP3 = "111100") then
		wind <= CWP - 1;
	elsif (OP = "10")and(OP3 = "111101") then
		wind <= CWP + 1;
	else
		wind <= CWP;
	end if;
	
	nCWP <= wind;	
	
end process;
end Behavioral;

