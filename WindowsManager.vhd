library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;

entity WindowsManager is
    Port ( rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           CWP : in  STD_LOGIC;
           nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrs2 : out STD_LOGIC_VECTOR (5 downto 0);
           nrd : out  STD_LOGIC_VECTOR (5 downto 0);
			  ncwp : out STD_LOGIC);
end WindowsManager;

architecture Behavioral of WindowsManager is
begin
	process(rs1, rs2, rd, op, op3, CWP)
	begin
		if op = "10" then
			if (op3 = "111100")  then -- SAVE
				ncwp <= '0';
			elsif (op3 = "111101") then -- RESTORE
				ncwp <= '1';
			else
				ncwp <= CWP;
			end if;
			
		end if;
		
		
		if ( rs1>= "11000" and rs1 <= "11111") then
			nrs1 <=conv_std_logic_vector(conv_integer(rs1) - conv_integer(CWP)* 16, 6) ;
		elsif (rs1>= "10000" and rs1 <= "10111") then
			nrs1 <= conv_std_logic_vector(conv_integer(rs1) + conv_integer(CWP) * 16,6) ;
		elsif ( rs1>= "01000" and rs1 <= "01111") then
			nrs1 <= conv_std_logic_vector(conv_integer(rs1) + conv_integer(CWP) * 16,6) ;
		else 
			nrs1(4 downto 0) <=  rs1;
			nrs1 (5) <= '0';
		end if;
		
		if ( rs2>= "11000" and rs2 <= "11111") then
			nrs2 <=conv_std_logic_vector(conv_integer(rs2) - conv_integer(CWP)* 16, 6) ;
		elsif (rs2>= "10000" and rs2 <= "10111") then
			nrs2 <= conv_std_logic_vector(conv_integer(rs2) + conv_integer(CWP) * 16,6) ;
		elsif ( rs2>= "01000" and rs2 <= "01111") then
			nrs2 <= conv_std_logic_vector(conv_integer(rs2) + conv_integer(CWP) * 16,6) ;
		else 
			nrs2(4 downto 0) <=  rs2;
			nrs2 (5) <= '0';
		end if;
		
		if (((op3 = "111101") and op = "10") or (CWP = '1' and op3 /= "111100")) then
			if ( rd>= "11000" and rd <= "11111") then
				nrd <=conv_std_logic_vector(conv_integer(rd) - conv_integer('1')* 16, 6) ;
			elsif (rd>= "10000" and rd <= "10111") then
				nrd <= conv_std_logic_vector(conv_integer(rd) + conv_integer('1') * 16,6) ;
			elsif ( rd>= "01000" and rd <= "01111") then
				nrd <= conv_std_logic_vector(conv_integer(rd) + conv_integer('1') * 16,6) ;
			else 
				nrd(4 downto 0) <=  rd;
				nrd (5) <= '0';
			end if;
		else
			nrd(4 downto 0) <=  rd;
			nrd (5) <= '0';
		end if;
		
		

	end process;

end Behavioral;