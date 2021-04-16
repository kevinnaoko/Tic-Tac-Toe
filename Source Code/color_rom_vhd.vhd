LIBRARY  IEEE; 
USE  IEEE.STD_LOGIC_1164.ALL; 
USE  IEEE.STD_LOGIC_ARITH.ALL; 
USE  IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY color_rom_vhd  IS 
	PORT( 
		Button_1_i		: IN STD_LOGIC;
		Button_2_i		: IN STD_LOGIC;
		ResetGame_i		: IN STD_LOGIC;
		ResetAll_i		: IN STD_LOGIC;
		B0_i			: IN STD_LOGIC_VECTOR (1 downto 0);
		B1_i			: IN STD_LOGIC_VECTOR (1 downto 0);
		B2_i			: IN STD_LOGIC_VECTOR (1 downto 0);
		B3_i			: IN STD_LOGIC_VECTOR (1 downto 0);
		B4_i			: IN STD_LOGIC_VECTOR (1 downto 0);
		B5_i			: IN STD_LOGIC_VECTOR (1 downto 0);
		B6_i			: IN STD_LOGIC_VECTOR (1 downto 0);
		B7_i			: IN STD_LOGIC_VECTOR (1 downto 0);
		B8_i			: IN STD_LOGIC_VECTOR (1 downto 0);
		Win_i        	: IN STD_LOGIC_VECTOR (1 downto 0);
		count_i		  	: IN STD_LOGIC_VECTOR (3 downto 0);
	    i_pixel_column  : IN STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	    i_pixel_row     : IN STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	    o_red           : OUT STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	    o_green         : OUT STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	    o_blue          : OUT STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	    ledtest			: OUT STD_LOGIC);
END color_rom_vhd; 

ARCHITECTURE behavioral OF color_rom_vhd  IS 
--GAMEBOARD [DYNAMIC]
CONSTANT R0   : INTEGER := 65;
CONSTANT R1   : INTEGER := 68;
CONSTANT R2   : INTEGER := 134;
CONSTANT R3   : INTEGER := 137;
CONSTANT R4   : INTEGER := 203;
CONSTANT R5   : INTEGER := 206;
CONSTANT R6   : INTEGER := 272;
CONSTANT R7   : INTEGER := 275;

CONSTANT R7b  : INTEGER := 280;
CONSTANT R8	  : INTEGER := 350;

CONSTANT C0   : INTEGER := 375;
CONSTANT C1   : INTEGER := 378;
CONSTANT C2   : INTEGER := 444;
CONSTANT C3   : INTEGER := 447;
CONSTANT C4   : INTEGER := 513;
CONSTANT C5   : INTEGER := 516;
CONSTANT C6   : INTEGER := 582;
CONSTANT C7   : INTEGER := 585;

SIGNAL b0_T                 :  STD_LOGIC; 
SIGNAL b1_T                 :  STD_LOGIC; 
SIGNAL b2_T                 :  STD_LOGIC;
SIGNAL b3_T                 :  STD_LOGIC;
SIGNAL b4_T                 :  STD_LOGIC;
SIGNAL b5_T                 :  STD_LOGIC;
SIGNAL b6_T                 :  STD_LOGIC;
SIGNAL b7_T                 :  STD_LOGIC;
SIGNAL b8_T                 :  STD_LOGIC; 
signal win_T				:  STD_LOGIC;
SIGNAL grid                 :  STD_LOGIC; 
SIGNAL selector_T    : STD_LOGIC;

--COSMETICS [STATIC]
-- "TIC
--  TAC
--  TOE"
CONSTANT C0a   	: INTEGER := 60;
CONSTANT C1a   	: INTEGER := 84;
CONSTANT C2a   	: INTEGER := 96;
CONSTANT C3a   	: INTEGER := 120;
CONSTANT C4a   	: INTEGER := 140;
CONSTANT C5a   	: INTEGER := 152;
CONSTANT C6a   	: INTEGER := 164;
CONSTANT C7a   	: INTEGER := 176;
CONSTANT C8a   	: INTEGER := 188;
CONSTANT C9a    : INTEGER := 200;
CONSTANT C10a    : INTEGER := 220;
CONSTANT C11a	: INTEGER := 232;
CONSTANT C12a   : INTEGER := 280;

CONSTANT R0a   	: INTEGER := 60;
CONSTANT R1a   	: INTEGER := 72;
CONSTANT R2a   	: INTEGER := 108;
CONSTANT R3a   	: INTEGER := 120;
CONSTANT R4a   	: INTEGER := 140;
CONSTANT R5a   	: INTEGER := 152;
CONSTANT R6a   	: INTEGER := 172;
CONSTANT R7a   	: INTEGER := 184;
CONSTANT R8a   	: INTEGER := 188;
CONSTANT R9a   	: INTEGER := 200;
CONSTANT R10a  	: INTEGER := 220;
CONSTANT R11a	: INTEGER := 232;
CONSTANT R12a   : INTEGER := 244;
CONSTANT R13a   : INTEGER := 256;
CONSTANT R14a   : INTEGER := 268;
CONSTANT R15a   : INTEGER := 280;

Signal titleColor1	: STD_LOGIC;
Signal titleColor2	: STD_LOGIC;
Signal titleColor3	: STD_LOGIC;

-- "WINS!"



BEGIN 


PROCESS(i_pixel_row,i_pixel_column, B0_i, B1_i, B2_i, B3_i, B4_i, B5_i, B6_i, B7_i, B8_i, b0_T,b1_T, b2_T, b3_T, b4_T,b5_T, b6_T,b7_T, b8_T, win_i, Win_T, grid)
BEGIN

--GAMEBOARD
--COLOR PARAMETERS
	--BOXES
	IF ((i_pixel_row > R1)  AND (i_pixel_row < R2)) AND ((i_pixel_column > C1)  AND (i_pixel_column < C2)) THEN b0_T <=  '1'; --kotak 0
	ELSE  b0_T <=  '0';
	END IF;
	  
	IF ((i_pixel_row > R1)  AND (i_pixel_row < R2)) AND ((i_pixel_column > C3)  AND (i_pixel_column < C4)) THEN b1_T <=  '1'; -- kotak 1
	ELSE b1_T <=  '0';
	END IF;
	  
	IF ((i_pixel_row > R1)  AND (i_pixel_row < R2)) AND ((i_pixel_column > C5)  AND (i_pixel_column < C6)) THEN b2_T <=  '1'; --kotak 2
	ELSE b2_T <=  '0';
	END IF;
	  
	IF ((i_pixel_row > R3)  AND (i_pixel_row < R4)) AND ((i_pixel_column > C1)  AND (i_pixel_column < C2)) THEN b3_T <=  '1'; --kotak 3
	ELSE b3_T <=  '0';
	END IF;
	  
	IF ((i_pixel_row > R3)  AND (i_pixel_row < R4)) AND ((i_pixel_column > C3)  AND (i_pixel_column < C4)) THEN b4_T <=  '1'; -- kotak 4
	ELSE b4_T <=  '0';
	END IF;
	  
	IF ((i_pixel_row > R3)  AND (i_pixel_row < R4)) AND ((i_pixel_column > C5)  AND (i_pixel_column < C6)) THEN b5_T <=  '1'; -- kotak 5
	ELSE b5_T <=  '0';
	END IF;
	  
	IF ((i_pixel_row > R5)  AND (i_pixel_row < R6)) AND ((i_pixel_column > C1)  AND (i_pixel_column < C2)) THEN b6_T <=  '1'; -- kotak 6
	ELSE b6_T <=  '0';
	END IF;
	  
	IF ((i_pixel_row > R5)  AND (i_pixel_row < R6)) AND ((i_pixel_column > C3)  AND (i_pixel_column < C4)) THEN b7_T <=  '1'; -- kotak 7
	ELSE b7_T <=  '0';
	END IF;
	  
	IF ((i_pixel_row > R5)  AND (i_pixel_row < R6)) AND ((i_pixel_column > C5)  AND (i_pixel_column < C6)) THEN b8_T <=  '1'; -- kotak 8
	ELSE b8_T <=  '0';
	END IF;
	  
	IF ((i_pixel_row > R7b)  AND (i_pixel_row <= R8)) AND ((i_pixel_column >= C0)  AND (i_pixel_column <= C7)  ) THEN win_T <=  '1'; -- pemenang
	ELSE win_i <=  '0';
	END IF;
	
  	
	--GRID
	IF 	(((i_pixel_row >= R0) AND (i_pixel_row <= R1)) AND ((i_pixel_column >= C0) AND (i_pixel_column <= C7)))
  	OR 	(((i_pixel_row >= R2) AND (i_pixel_row <= R3)) AND ((i_pixel_column >= C0) AND (i_pixel_column <= C7)))
    OR 	(((i_pixel_row >= R4) AND (i_pixel_row <= R5)) AND ((i_pixel_column >= C0) AND (i_pixel_column <= C7)))
	OR 	(((i_pixel_row >= R6) AND (i_pixel_row <= R7)) AND ((i_pixel_column >= C0) AND (i_pixel_column <= C7)))-- horizontal
	OR 	(((i_pixel_row >= R0) AND (i_pixel_row <= R7)) AND ((i_pixel_column >= C0) AND (i_pixel_column <= C1)))-- vertical
  	OR 	(((i_pixel_row >= R0) AND (i_pixel_row <= R7)) AND ((i_pixel_column >= C2) AND (i_pixel_column <= C3)))
    OR 	(((i_pixel_row >= R0) AND (i_pixel_row <= R7)) AND ((i_pixel_column >= C4) AND (i_pixel_column <= C5)))
	OR 	(((i_pixel_row >= R0) AND (i_pixel_row <= R7)) AND ((i_pixel_column >= C6) AND (i_pixel_column <= C7))) 
	THEN grid <=  '1';
	ELSE grid <=  '0';
	END IF;
	
	--TITLE
	IF (((i_pixel_row >= R0a )  AND (i_pixel_row < R1a )) AND ((i_pixel_column >= C0a )  AND (i_pixel_column < C3a ))) -- 60 up to 72
	OR (((i_pixel_row >= R0a )  AND (i_pixel_row < R1a )) AND ((i_pixel_column >= C4a )  AND (i_pixel_column < C9a )))
	OR (((i_pixel_row >= R0a )  AND (i_pixel_row < R1a )) AND ((i_pixel_column >= C10a)  AND (i_pixel_column < C12a)))
	
	OR (((i_pixel_row >= R1a )  AND (i_pixel_row < R2a )) AND ((i_pixel_column >= C1a )  AND (i_pixel_column < C2a ))) -- 72 up to 108
	OR (((i_pixel_row >= R1a )  AND (i_pixel_row < R2a )) AND ((i_pixel_column >= C6a )  AND (i_pixel_column < C7a )))
	OR (((i_pixel_row >= R1a )  AND (i_pixel_row < R2a )) AND ((i_pixel_column >= C10a)  AND (i_pixel_column < C11a)))
	
	OR (((i_pixel_row >= R2a )  AND (i_pixel_row < R3a )) AND ((i_pixel_column >= C1a )  AND (i_pixel_column < C2a ))) -- 108 - 120
	OR (((i_pixel_row >= R2a )  AND (i_pixel_row < R3a )) AND ((i_pixel_column >= C4a )  AND (i_pixel_column < C9a )))
	OR (((i_pixel_row >= R2a )  AND (i_pixel_row < R3a )) AND ((i_pixel_column >= C10a)  AND (i_pixel_column < C12a)))
	THEN titleColor1 <=  '1';
	ELSE titleColor1 <=  '0';
	END IF;
	
	IF (((i_pixel_row >= R4a )  AND (i_pixel_row < R5a )) AND ((i_pixel_column >= C0a )  AND (i_pixel_column < C3a ))) -- 140 up to 152
	OR (((i_pixel_row >= R4a )  AND (i_pixel_row < R5a )) AND ((i_pixel_column >= C4a )  AND (i_pixel_column < C9a )))
	OR (((i_pixel_row >= R4a )  AND (i_pixel_row < R5a )) AND ((i_pixel_column >= C10a)  AND (i_pixel_column < C12a)))
	--
	OR (((i_pixel_row >= R5a )  AND (i_pixel_row < R6a )) AND ((i_pixel_column >= C1a )  AND (i_pixel_column < C2a ))) -- 152 up to 172
	OR (((i_pixel_row >= R5a )  AND (i_pixel_row < R6a )) AND ((i_pixel_column >= C4a )  AND (i_pixel_column < C5a )))
	OR (((i_pixel_row >= R5a )  AND (i_pixel_row < R6a )) AND ((i_pixel_column >= C8a )  AND (i_pixel_column < C9a )))
	OR (((i_pixel_row >= R5a )  AND (i_pixel_row < R6a )) AND ((i_pixel_column >= C10a)  AND (i_pixel_column < C11a)))
	--
	OR (((i_pixel_row >= R6a )  AND (i_pixel_row < R7a )) AND ((i_pixel_column >= C1a )  AND (i_pixel_column < C2a ))) -- 172 up to 184
	OR (((i_pixel_row >= R6a )  AND (i_pixel_row < R7a )) AND ((i_pixel_column >= C4a )  AND (i_pixel_column < C9a )))
	OR (((i_pixel_row >= R6a )  AND (i_pixel_row < R7a )) AND ((i_pixel_column >= C10a)  AND (i_pixel_column < C11a)))
	--
	OR (((i_pixel_row >= R7a )  AND (i_pixel_row < R8a )) AND ((i_pixel_column >= C1a )  AND (i_pixel_column < C2a ))) -- 184 up to 188
	OR (((i_pixel_row >= R7a )  AND (i_pixel_row < R8a )) AND ((i_pixel_column >= C4a )  AND (i_pixel_column < C5a )))
	OR (((i_pixel_row >= R7a )  AND (i_pixel_row < R8a )) AND ((i_pixel_column >= C8a )  AND (i_pixel_column < C9a )))
	OR (((i_pixel_row >= R7a )  AND (i_pixel_row < R8a )) AND ((i_pixel_column >= C10a)  AND (i_pixel_column < C11a)))
	--
	OR (((i_pixel_row >= R8a )  AND (i_pixel_row < R9a )) AND ((i_pixel_column >= C1a )  AND (i_pixel_column < C2a ))) -- 188 up to 200
	OR (((i_pixel_row >= R8a )  AND (i_pixel_row < R9a )) AND ((i_pixel_column >= C4a )  AND (i_pixel_column < C5a )))
	OR (((i_pixel_row >= R8a )  AND (i_pixel_row < R9a )) AND ((i_pixel_column >= C8a )  AND (i_pixel_column < C9a )))
	OR (((i_pixel_row >= R8a )  AND (i_pixel_row < R9a )) AND ((i_pixel_column >= C10a)  AND (i_pixel_column < C12a)))	
	THEN titleColor2 <=  '1';
	ELSE titleColor2 <=  '0';
	END IF;
	
	IF (((i_pixel_row >= R10a)  AND (i_pixel_row < R11a)) AND ((i_pixel_column >= C0a )  AND (i_pixel_column < C3a ))) -- 220 up to 232
	OR (((i_pixel_row >= R10a)  AND (i_pixel_row < R11a)) AND ((i_pixel_column >= C4a )  AND (i_pixel_column < C9a )))
	OR (((i_pixel_row >= R10a)  AND (i_pixel_row < R11a)) AND ((i_pixel_column >= C10a)  AND (i_pixel_column < C12a)))
	--
	OR (((i_pixel_row >= R11a)  AND (i_pixel_row < R12a)) AND ((i_pixel_column >= C1a )  AND (i_pixel_column < C2a ))) -- 232 up to 244
	OR (((i_pixel_row >= R11a)  AND (i_pixel_row < R12a)) AND ((i_pixel_column >= C4a )  AND (i_pixel_column < C5a )))
	OR (((i_pixel_row >= R11a)  AND (i_pixel_row < R12a)) AND ((i_pixel_column >= C8a )  AND (i_pixel_column < C9a )))
	OR (((i_pixel_row >= R11a)  AND (i_pixel_row < R12a)) AND ((i_pixel_column >= C10a)  AND (i_pixel_column < C11a)))
	--
	OR (((i_pixel_row >= R12a)  AND (i_pixel_row < R13a)) AND ((i_pixel_column >= C1a )  AND (i_pixel_column < C2a ))) -- 244 up to 256
	OR (((i_pixel_row >= R12a)  AND (i_pixel_row < R13a)) AND ((i_pixel_column >= C4a )  AND (i_pixel_column < C5a )))
	OR (((i_pixel_row >= R12a)  AND (i_pixel_row < R13a)) AND ((i_pixel_column >= C8a )  AND (i_pixel_column < C9a )))
	OR (((i_pixel_row >= R12a)  AND (i_pixel_row < R13a)) AND ((i_pixel_column >= C10a)  AND (i_pixel_column < C12a)))
	--
	OR (((i_pixel_row >= R13a)  AND (i_pixel_row < R14a)) AND ((i_pixel_column >= C1a )  AND (i_pixel_column < C2a ))) -- 256 up to 268
	OR (((i_pixel_row >= R13a)  AND (i_pixel_row < R14a)) AND ((i_pixel_column >= C4a )  AND (i_pixel_column < C5a )))
	OR (((i_pixel_row >= R13a)  AND (i_pixel_row < R14a)) AND ((i_pixel_column >= C8a )  AND (i_pixel_column < C9a )))
	OR (((i_pixel_row >= R13a)  AND (i_pixel_row < R14a)) AND ((i_pixel_column >= C10a)  AND (i_pixel_column < C11a)))
	--
	OR (((i_pixel_row >= R14a)  AND (i_pixel_row < R15a)) AND ((i_pixel_column >= C1a )  AND (i_pixel_column < C2a ))) -- 268 up to 280  4rtreg
	OR (((i_pixel_row >= R14a)  AND (i_pixel_row < R15a)) AND ((i_pixel_column >= C4a )  AND (i_pixel_column < C9a )))
	OR (((i_pixel_row >= R14a)  AND (i_pixel_row < R15a)) AND ((i_pixel_column >= C10a)  AND (i_pixel_column < C12a)))
	THEN titleColor3 <=  '1'; 
	ELSE titleColor3 <=  '0';
	END IF;

-- COLOR DECLARATION
	--BOXES AND SELECTOR
	IF (b0_T = '1') THEN  
		if 	(count_i = 0) then o_red <= X"00"; o_green <= X"00"; o_blue <= X"FF"; 
		else
			if 		(B0_i= "01") then o_red <= X"FF"; o_green <= X"00"; o_blue <= X"00";
			elsif 	(B0_i= "10") THEN o_red <= X"00"; o_green <= X"FF"; o_blue <= X"00"; 
			elsif 	(B0_i= "00") THEN o_red <= X"00"; o_green <= X"00"; o_blue <= X"00"; 
			end if;
		END IF;

	ELSIF (b1_T = '1') THEN 
		if 	(count_i = 1) then o_red <= X"00"; o_green <= X"00"; o_blue <= X"FF"; 
		else 
			if 		(B1_i= "01") then o_red <= X"FF"; o_green <= X"00"; o_blue <= X"00";
			elsif 	(B1_i= "10") THEN o_red <= X"00"; o_green <= X"FF"; o_blue <= X"00";
			elsif 	(B1_i= "00") THEN o_red <= X"00"; o_green <= X"00"; o_blue <= X"00"; 
			END IF;
		end if;
		
	ELSIF (b2_T = '1') THEN  
		if 	(count_i = 2) then o_red <= X"00"; o_green <= X"00"; o_blue <= X"FF"; 
		else 
			if 		(B2_i= "01") then o_red <= X"FF"; o_green <= X"00"; o_blue <= X"00";
			elsif 	(B2_i= "10") THEN o_red <= X"00"; o_green <= X"FF"; o_blue <= X"00";
			elsif 	(B2_i= "00") THEN o_red <= X"00"; o_green <= X"00"; o_blue <= X"00"; 
			end if;
		END IF;

	ELSIF (b3_T = '1') THEN  
		if 	(count_i = 3) then o_red <= X"00"; o_green <= X"00"; o_blue <= X"FF"; 
		else 
			if 		(B3_i= "01") then o_red <= X"FF"; o_green <= X"00"; o_blue <= X"00";
			elsif 	(B3_i= "10") THEN o_red <= X"00"; o_green <= X"FF"; o_blue <= X"00";
			elsif 	(B3_i= "00") THEN o_red <= X"00"; o_green <= X"00"; o_blue <= X"00"; 
			END IF;
		end if;
		
	ELSIF (b4_T = '1') THEN  
		if 	(count_i = 4) then o_red <= X"00"; o_green <= X"00"; o_blue <= X"FF"; 
		else
			if 		(B4_i= "01") then o_red <= X"FF"; o_green <= X"00"; o_blue <= X"00";
			elsif 	(B4_i= "10") THEN o_red <= X"00"; o_green <= X"FF"; o_blue <= X"00";
			elsif 	(B4_i= "00") THEN o_red <= X"00"; o_green <= X"00"; o_blue <= X"00"; 
			end if;
		END IF;

	ELSIF (b5_T = '1') THEN  
		if 	(count_i = 5) then o_red <= X"00"; o_green <= X"00"; o_blue <= X"FF"; 
		else
			if 		(B5_i= "01") then o_red <= X"FF"; o_green <= X"00"; o_blue <= X"00";
			elsif 	(B5_i= "10") THEN o_red <= X"00"; o_green <= X"FF"; o_blue <= X"00";
			elsif 	(B5_i= "00") THEN o_red <= X"00"; o_green <= X"00"; o_blue <= X"00"; 
			end if;
		END IF;

	ELSIF (b6_T = '1') THEN 
		if 	(count_i = 6) then o_red <= X"00"; o_green <= X"00"; o_blue <= X"FF"; 
		else 
			if 		(B6_i= "01") then o_red <= X"FF"; o_green <= X"00"; o_blue <= X"00";
			elsif 	(B6_i= "10") THEN o_red <= X"00"; o_green <= X"FF"; o_blue <= X"00";
			elsif 	(B6_i= "00") THEN o_red <= X"00"; o_green <= X"00"; o_blue <= X"00"; 
			end if;
		END IF;

	ELSIF (b7_T = '1') THEN
		if 	(count_i = 7) then o_red <= X"00"; o_green <= X"00"; o_blue <= X"FF"; 
		else  
			if 		(B7_i= "01") then o_red <= X"FF"; o_green <= X"00"; o_blue <= X"00";
			elsif 	(B7_i= "10") THEN o_red <= X"00"; o_green <= X"FF"; o_blue <= X"00";
			elsif 	(B7_i= "00") THEN o_red <= X"00"; o_green <= X"00"; o_blue <= X"00"; 
			end if;
		END IF;

	ELSIF (b8_T = '1') THEN  
		if 	(count_i = 8) then o_red <= X"00"; o_green <= X"00"; o_blue <= X"FF"; 
		else
			if 		(B8_i= "01") then o_red <= X"FF"; o_green <= X"00"; o_blue <= X"00";
			elsif 	(B8_i= "10") THEN o_red <= X"00"; o_green <= X"FF"; o_blue <= X"00";
			elsif 	(B8_i= "00") THEN o_red <= X"00"; o_green <= X"00"; o_blue <= X"00"; 
			end if;
		END IF;

	--GRID
	ELSIF (grid = '1') THEN  o_red <= X"FF"; o_green <= X"FF"; o_blue <= X"FF"; 
	
	ELSIF (titleColor1 ='1' ) THEN  o_red <= X"22"; o_green <= X"00"; o_blue <= X"FF"; 
	ELSIF (titleColor2 ='1' ) THEN  o_red <= X"22"; o_green <= X"00"; o_blue <= X"FF"; 
	ELSIF (titleColor3 ='1' ) THEN  o_red <= X"22"; o_green <= X"00"; o_blue <= X"FF"; 
	ELSIF (b0_T = '0' and b1_T = '0'and b2_T = '0' and b3_T = '0'and b4_T = '0'and b5_T = '0'and b6_T = '0'and b7_T = '0'and b8_T = '0'and grid = '0' and titleColor1 ='0' and titleColor2 ='0' and titleColor3 ='0' ) then 
		o_red <= X"00"; o_green <= X"00"; o_blue <= X"00"; 
	END IF;
	
	--WIN
	IF (win_T = '1' AND Win_i = "10" ) THEN  o_red <= X"00"; o_green <= X"FF"; o_blue <= X"00"; 
	ELSIF (win_T = '1' AND Win_i = "01" ) THEN  o_red <= X"FF"; o_green <= X"00"; o_blue <= X"00"; 
	ELSIF (win_T = '1' AND Win_i = "11" ) THEN  o_red <= X"77"; o_green <= X"77"; o_blue <= X"77"; 
	END IF;
    
	--TITLE
	
END PROCESS;

END behavioral; 