library IEEE;  
use IEEE.std_logic_1164.all;  
use IEEE.std_logic_arith.all;  
use IEEE.std_logic_unsigned.all;  

entity tictactoe is
	port (
		button_1	: in std_logic;
		button_2	: in std_logic;
		resetGame	: in std_logic;
		o_b0, o_b1, o_b2, o_b3, o_b4, o_b5, o_b6, o_b7, o_b8, o_win 	: out std_logic_vector (1 downto 0);
		o_count, o_countTurn											: out std_logic_vector (3 downto 0);
		rst, clk	: in std_logic
	);
end entity;
 

architecture FSM of tictactoe is
--P1 and P2 denoted as 10 and 01 respectively

type states is (P1_idle, P1_select, P1_press, P2_idle, P2_select, P2_press, winCheck, OVER); 
signal cstate 								: states;
signal count, countTurn 					: std_logic_vector (3 downto 0) := "0000"; 
signal b0, b1, b2, b3, b4, b5, b6, b7, b8	: std_logic_vector (1 downto 0) := "00";
signal win 									: std_logic_vector (1 downto 0) := "00";
signal current_player 						: std_logic_vector (1 downto 0) := "00";
--component CLOCKDIV is 
--	port(
--	CLK       : IN std_logic;
--	DIVOUT    : buffer std_logic
--	);
--end component;

begin
--detik : CLOCKDIV port map (CLK => clk, DIVOUT => clk_i);

	process (rst, clk)
	begin 
	if rising_edge(clk) then
	case cstate is
		when P1_idle =>			-- Menunggu input P1
			if button_1 = '1' then cstate <= P1_select;
			elsif button_2 = '1' then cstate <= P1_press;
			else cstate <= P1_idle;
			end if;	
		when P1_select =>		-- Menambah count apabila button_1 ditekan untuk cycle posisi penempatan bidak
			if (count < "1000") then 
				count <= count + 1;
				cstate <= P1_idle;
			else count <= "0000"; cstate <= P1_idle;
			end if;
			
		when P1_press =>		-- Meletakkan bidak pada papan apabila button_2 ditekan, lalu mengarahkan ke state pengecekan kemenangan serta mengassign current_player menjadi P2
			if (count = 0 and b0 = "00") then b0 <= "10"; cstate <= winCheck; current_player <= "01"; countTurn <= countTurn + 1;
			elsif (count = 1 and b1 = "00") then b1 <= "10"; cstate <= winCheck; current_player <= "01"; countTurn <= countTurn + 1;
			elsif (count = 2 and b2 = "00") then b2 <= "10"; cstate <= winCheck; current_player <= "01"; countTurn <= countTurn + 1;
			elsif (count = 3 and b3 = "00") then b3 <= "10"; cstate <= winCheck; current_player <= "01"; countTurn <= countTurn + 1;
			elsif (count = 4 and b4 = "00") then b4 <= "10"; cstate <= winCheck; current_player <= "01"; countTurn <= countTurn + 1;
			elsif (count = 5 and b5 = "00") then b5 <= "10"; cstate <= winCheck; current_player <= "01"; countTurn <= countTurn + 1;
			elsif (count = 6 and b6 = "00") then b6 <= "10"; cstate <= winCheck; current_player <= "01"; countTurn <= countTurn + 1;
			elsif (count = 7 and b7 = "00") then b7 <= "10"; cstate <= winCheck; current_player <= "01"; countTurn <= countTurn + 1;
			elsif (count = 8 and b8 = "00") then b8 <= "10"; cstate <= winCheck; current_player <= "01"; countTurn <= countTurn + 1;
			else count <= "0000" ; cstate <= P1_select;
			end if;

		when P2_idle =>			-- Menunggu input P2
			if button_1 = '1' then cstate <= P2_select;
			elsif button_2 = '1' then cstate <= P2_press;
			else cstate <= P2_idle;
			end if;
		when P2_select =>		-- Menambah count apabila button_1 ditekan untuk cycle posisi penempatan bidak
			if (count < "1000") then 
				count <= count + 1;
				cstate <= P2_idle;
			else count <= "0000"; cstate <= P2_idle;
			end if;
			
		when P2_press =>		-- Meletakkan bidak pada papan apabila button_2 ditekan, lalu mengarahkan ke state pengecekan kemenangan serta mengassign current_player menjadi P1
			if (count = 0 and b0 = "00") then b0 <= "01"; cstate <= winCheck; current_player <= "10"; countTurn <= countTurn + 1;
			elsif (count = 1 and b1 = "00") then b1 <= "01"; cstate <= winCheck; current_player <= "10"; countTurn <= countTurn + 1;
			elsif (count = 2 and b2 = "00") then b2 <= "01"; cstate <= winCheck; current_player <= "10"; countTurn <= countTurn + 1;
			elsif (count = 3 and b3 = "00") then b3 <= "01"; cstate <= winCheck; current_player <= "10"; countTurn <= countTurn + 1;
			elsif (count = 4 and b4 = "00") then b4 <= "01"; cstate <= winCheck; current_player <= "10"; countTurn <= countTurn + 1;
			elsif (count = 5 and b5 = "00") then b5 <= "01"; cstate <= winCheck; current_player <= "10"; countTurn <= countTurn + 1;
			elsif (count = 6 and b6 = "00") then b6 <= "01"; cstate <= winCheck; current_player <= "10"; countTurn <= countTurn + 1;
			elsif (count = 7 and b7 = "00") then b7 <= "01"; cstate <= winCheck; current_player <= "10"; countTurn <= countTurn + 1;
			elsif (count = 8 and b8 = "00") then b8 <= "01"; cstate <= winCheck; current_player <= "10"; countTurn <= countTurn + 1;
			else count <= "0000" ; cstate <= P2_select;
			end if;			
			
		when winCheck =>		-- Pengecekan kemenangan
			if 		(b0 = "10" and b1 = "10" and b2 = "10") or (b3 = "10" and b4 = "10" and b5 = "10") or  
					(b6 = "10" and b7 = "10" and b8 = "10") or (b0 = "10" and b3 = "10" and b6 = "10") or
					(b1 = "10" and b4 = "10" and b7 = "10") or (b2 = "10" and b5 = "10" and b8 = "10") or
					(b0 = "10" and b4 = "10" and b8 = "10") or (b2 = "10" and b4 = "10" and b6 = "10") then 
					win <= "10"; cstate <= OVER; --P1 WINS
			elsif 	(b0 = "01" and b1 = "01" and b2 = "01") or (b3 = "01" and b4 = "01" and b5 = "01") or
					(b6 = "01" and b7 = "01" and b8 = "01") or (b0 = "01" and b3 = "01" and b6 = "01") or
					(b1 = "01" and b4 = "01" and b7 = "01") or (b2 = "01" and b5 = "01" and b8 = "01") or
					(b0 = "01" and b4 = "01" and b8 = "01") or (b2 = "01" and b4 = "01" and b6 = "01") then 
					win <= "01"; cstate <= OVER; --P2 WINS
			elsif   (countTurn > "1000") then 
					win <= "11"; cstate <= OVER; --TIE
			else
				if current_player <= "01" then count <= "0000"; cstate <= P2_idle;
				elsif current_player <= "10" then count <= "0000"; cstate <= P1_idle;
				end if;
			end if;
			
		when OVER =>			-- Menunggu input apakah ingin bermain lagi atau tidak
			if (resetGame = '1') then
				win <= "00";
				countTurn <= "0000";
				count <= "0000";
				b0 <= "00";
				b1 <= "00";
				b2 <= "00";
				b3 <= "00";
				b4 <= "00";
				b5 <= "00";
				b6 <= "00";
				b7 <= "00";
				b8 <= "00";
				cstate <= P1_idle;
			end if;
	end case;
	end if;
	end process;

	o_b0 <= b0;
	o_b1 <= b1;
	o_b2 <= b2;
	o_b3 <= b3;
	o_b4 <= b4;
	o_b5 <= b5;
	o_b6 <= b6;
	o_b7 <= b7;
	o_b8 <= b8;
	o_win <= win;
	o_count <= count;
	o_countTurn <= countTurn;
	
end FSM;
	