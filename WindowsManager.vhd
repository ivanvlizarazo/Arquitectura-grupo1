----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:31:05 05/02/2018 
-- Design Name: 
-- Module Name:    WindowsManager - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WindowsManager is
    Port ( rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           cwp : in  STD_LOGIC;
           nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrd : out  STD_LOGIC_VECTOR (5 downto 0);
           ncwp : out  STD_LOGIC);
end WindowsManager;

architecture Behavioral of WindowsManager is

begin

	process(rs1, rs2, rd, op, op3, cwp)
		begin
		
		
			-------------SAVE AND RESTORE -----------------------
			if(op = "10") then
				if (op3 = "111100") then ---SAVE
					ncwp <= '0';
				elsif (op3 = "111101") then --RESTORE
					ncwp <= '1';
				end if;
			end if;
		
			------- RS1 ----------------------------------
			----- out , local ------------
			if(conv_integer(rs1) >= 8) and (conv_integer(rs1) <= 23) then
				
				if(cwp = '1') then
					nrs1 <= ('0' & rs1) + "010000";
				elsif (cwp = '0') then
					nrs1 <= ('0' & rs1);
				end if;
			---- globales-------	
			elsif(conv_integer(rs1) <= 7 ) then 
				nrs1 <= ('0' & rs1);
				else 
				------- i (entrada) ---------------
					if(cwp = '1') then
						nrs1 <= ('0' & rs1) - "010000";
						elsif (cwp = '0') then
						nrs1 <= ('0' & rs1);
					end if; 
			end if;
			
			------- RS2 ----------------------------------
			if(conv_integer(rs2) >= 8) and (conv_integer(rs2) <= 23) then
				
				if(cwp = '1') then
					nrs2 <= ('0' & rs2) + "010000";
				elsif (cwp = '0') then
					nrs2 <= ('0' & rs2);
				end if;
			
			elsif(conv_integer(rs2) <= 7 ) then 
				nrs2 <= ('0' & rs2);
				else
					if(cwp = '1') then
						nrs2 <= ('0' & rs2) - "010000";
						elsif (cwp = '0') then
						nrs2 <= ('0' & rs2);
					end if;	
			end if;
			
			

			
			------- RD ----------------------------------
			
			if(conv_integer(rd) >= 8) and (conv_integer(rd) <= 23) then
				
				if(cwp = '1') then
					nrd <= ('0' & rd) + "010000";
				elsif (cwp = '0') then
					nrd <= ('0' & rd);
				end if;
			
			elsif(conv_integer(rd) <= 7 ) then 
				nrd <= ('0' & rd);			
				else 
					if(cwp = '1') then
						nrd <= ('0' & rd) - "010000";
						elsif (cwp = '0') then
						nrd <= ('0' & rd);
					end if;
			end if;
			
			
	end process;


end Behavioral;

