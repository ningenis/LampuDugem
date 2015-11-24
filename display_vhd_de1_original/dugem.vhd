--Source Code Praktikum Sistem Digital Percobaan 6
--Proyek Perancangan Rangkaian Digital
--FSM untuk lampu dugem
--VHDL by Azka Ihsan Nurrahman (18211002) dan M. Ogin Hasanuddin (13211006)

LIBRARY IEEE; --Library Standar IEEE
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY dugem IS --Entitas Dugem
PORT 	(
		clock : IN STD_LOGIC; --Clock FPGA
		reset : IN STD_LOGIC; --Tombol Reset
		enter : IN STD_LOGIC; --Input Enter
		lampu : OUT STD_LOGIC_VECTOR (2 downto 0); --Lampu Dugem 
		count1: OUT STD_LOGIC_VECTOR(3 downto 0) --Waktu Lampu Dugem
		);
END dugem;

ARCHITECTURE Behavioral OF dugem IS
TYPE TipeState IS (s0, s1, s2, s3, s4, s5, s6, s7, s8); --Tipe State
SIGNAL PresentState, NextState: TipeState; --Present State
SIGNAL count: STD_LOGIC_VECTOR(3 downto 0); -- Signal untuk menghitung waktu
CONSTANT konstan2: STD_LOGIC_VECTOR(3 downto 0) := "0010"; --Desimal 2 dalam biner
CONSTANT konstan1: STD_LOGIC_VECTOR(3 downto 0) := "0001"; --Desimal 1 dalam biner

COMPONENT CLOCKDIV IS --Komponen Clock Divider
	PORT (CLK: IN STD_LOGIC;
		  DIVOUT: INOUT STD_LOGIC);
END COMPONENT;

SIGNAL C: STD_LOGIC; 


BEGIN 

	F: CLOCKDIV  port map (CLK=>clock, DIVOUT=>C); --Counter untuk FSM
	count1 <= count;
	process (C,reset)
	begin
	if (C'event) and (C = '1') then
		count <= count + 1; 
		if reset = '0' then
			PresentState <= s0;
			count <= X"0";
		else
			PresentState <= NextState;
		end if;	 
	end if;
end process;

process (PresentState) --Logika FSM
	begin
		case PresentState is
			when s0 => 
				if (enter = '1') then
					NextState <= s3;
				else
					if (count < konstan2) then
						NextState <= PresentState;
					else
						NextState <= s1;
					end if;
				end if;
			when s1 => 
				if (enter = '1') then
					NextState <= s3;
				else
					if (count < konstan2) then
						NextState <= PresentState;
					else
						NextState <= s2;
					end if;
				end if;
			when s2 => 
				if (enter = '1') then
					NextState <= s3;
				else
					if (count < konstan2) then
						NextState <= PresentState;
					else
						NextState <= s0;
					end if;
				end if;
			when s3 =>
				if (enter = '0') then
					NextState <= s6;
				else
					if (count < konstan2) then
						NextState <= PresentState;
					else
						NextState <= s4;
					end if;
				end if;
			when s4 => 
				if (enter = '0') then
					NextState <= s6;
				else
					if (count < konstan2) then
						NextState <= PresentState;
					else
						NextState <= s5;
					end if;
				end if;
			when s5 => 
				if (enter = '0') then
					NextState <= s6;
				else
					if (count < konstan2) then
						NextState <= PresentState;
					else
						NextState <= s3;
					end if;
				end if;
			when s6 => 
				if (enter = '1') then
					NextState <= s0;
				else
					if (count < konstan2) then
						NextState <= PresentState;
					else
						NextState <= s7;
					end if;
				end if;
			when s7 => 
				if (enter = '1') then
					NextState <= s0;
				else
					if (count < konstan2) then
						NextState <= PresentState;
					else
						NextState <= s8;
					end if;
				end if;
			when s8 => 
				if (enter = '1') then
					NextState <= s0;
				else
					if (count < konstan2) then
						NextState <= PresentState;
					else
						NextState <= s6;
					end if;
				end if;
		end case; 
end process; 

process(PresentState) --Proses Output berupa nyala lampu
	begin
		case PresentState is
			when s0 => lampu <= "101"; 
			when s1 => lampu <= "011"; 	
			when s2 => lampu <= "110"; 
			when s3 => lampu <= "011"; 
			when s4 => lampu <= "110"; 
			when s5 => lampu <= "101";
			when s6 => lampu <= "101"; 
			when s7 => lampu <= "011"; 
			when s8 => lampu <= "110";  
		end case;
	end process; 

END Behavioral;