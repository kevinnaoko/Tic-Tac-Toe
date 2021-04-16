LIBRARY  IEEE; 
USE  IEEE.STD_LOGIC_1164.ALL; 
USE  IEEE.STD_LOGIC_ARITH.ALL; 
USE  IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY top_level_vhd  IS 
	PORT( 
	    CLOCK_50   : IN STD_LOGIC;
	    SW         : IN STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	    VGA_R      : OUT STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	    VGA_G      : OUT STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	    VGA_B      : OUT STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	    VGA_HS     : OUT STD_LOGIC;
	    VGA_VS     : OUT STD_LOGIC;
	    VGA_CLK    : OUT STD_LOGIC;
	    VGA_BLANK  : OUT STD_LOGIC;
	    GPIO_0     : OUT STD_LOGIC_VECTOR( 35 DOWNTO 0 );
	    LEDR       : BUFFER STD_LOGIC_VECTOR( 9 DOWNTO 0 ));
END top_level_vhd; 

ARCHITECTURE behavioral OF top_level_vhd  IS 
   
SIGNAL  Button_1_Top 	: STD_LOGIC;              
SIGNAL  Button_2_Top 	: STD_LOGIC;              
SIGNAL  ResetGame_Top 	: STD_LOGIC;              
SIGNAL  ResetAll_Top	: STD_LOGIC;        
SIGNAL  ledtest2		: STD_LOGIC;  

SIGNAL  clk_o			: STD_LOGIC;
 
SIGNAL  B0temp			: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL  B1temp			: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL  B2temp			: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL  B3temp			: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL  B4temp			: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL  B5temp			: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL  B6temp			: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL  B7temp			: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL  B8temp			: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	Win_i1temp		: STD_LOGIC_VECTOR (1 downto 0);
SIGNAL	count_itemp		:  STD_LOGIC_VECTOR (3 downto 0);

COMPONENT display_vhd  IS 
	PORT( 
	    i_clk			     : IN STD_LOGIC;
		Button_1_i_disp		 : IN STD_LOGIC;
		Button_2_i_disp		 : IN STD_LOGIC;
		ResetGame_i_disp	 : IN STD_LOGIC;
		ResetAll_i_disp		 : IN STD_LOGIC;
		B0_i_disp			 : IN STD_LOGIC_VECTOR (1 downto 0);
		B1_i_disp			 : IN STD_LOGIC_VECTOR (1 downto 0);
		B2_i_disp			 : IN STD_LOGIC_VECTOR (1 downto 0);
		B3_i_disp			 : IN STD_LOGIC_VECTOR (1 downto 0);
		B4_i_disp			 : IN STD_LOGIC_VECTOR (1 downto 0);
		B5_i_disp			 : IN STD_LOGIC_VECTOR (1 downto 0);
		B6_i_disp			 : IN STD_LOGIC_VECTOR (1 downto 0);
		B7_i_disp			 : IN STD_LOGIC_VECTOR (1 downto 0);
		B8_i_disp			 : IN STD_LOGIC_VECTOR (1 downto 0);
		Win_i1_disp			 : IN STD_LOGIC_VECTOR (1 downto 0);
		count_i_disp		 : IN STD_LOGIC_VECTOR (3 downto 0);
	    VGA_R           : OUT STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	    VGA_G           : OUT STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	    VGA_B           : OUT STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	    VGA_HS          : OUT STD_LOGIC;
	    VGA_VS          : OUT STD_LOGIC;
	    VGA_CLK         : OUT STD_LOGIC;
	    VGA_BLANK       : OUT STD_LOGIC;
	    ledtest1		: OUT STD_LOGIC);
END COMPONENT; 

component CLOCKDIV is 
	port(
	CLK       : IN std_logic;
	DIVOUT    : buffer std_logic
	);
end component;

component tictactoe is
	port (
		button_1	: in std_logic;
		button_2	: in std_logic;
		resetGame	: in std_logic;
		o_b0, o_b1, o_b2, o_b3, o_b4, o_b5, o_b6, o_b7, o_b8, o_win 	: out std_logic_vector (1 downto 0);
		o_count, o_countTurn											: out std_logic_vector (3 downto 0);
		rst, clk	: in std_logic
	);
end component;

BEGIN 

module_vga : display_vhd 
   PORT MAP (
	i_clk			   	 => CLOCK_50,
	Button_1_i_disp		 => Button_1_Top,
	Button_2_i_disp		 => Button_2_Top,
	ResetGame_i_disp	 => ResetGame_Top,
	ResetAll_i_disp		 => ResetAll_Top,
	B0_i_disp			 => B0temp,
	B1_i_disp			 => B1temp,
	B2_i_disp			 => B2temp,
	B3_i_disp			 => B3temp,
	B4_i_disp			 => B4temp,
	B5_i_disp			 => B5temp,
	B6_i_disp			 => B6temp,
	B7_i_disp			 => B7temp,
	B8_i_disp			 => B8temp,
	Win_i1_disp			 => Win_i1temp,
	count_i_disp		 => count_itemp,
    VGA_R                => VGA_R,  
    VGA_G                => VGA_G,  
    VGA_B                => VGA_B,
    VGA_HS               => VGA_HS,  
    VGA_VS               => VGA_VS,
    VGA_CLK              => VGA_CLK,
    VGA_BLANK            => VGA_BLANK,
    ledtest1 			 => ledtest2
);

tictactoe0 : tictactoe
	port map(
	button_1 	=> Button_1_Top,
	button_2 	=> Button_2_Top,
	resetGame	=> ResetGame_Top,
	o_b0		=> B0temp, 
	o_b1		=> B1temp,
	o_b2		=> B2temp,
	o_b3		=> B3temp, 
	o_b4		=> B4temp, 
	o_b5		=> B5temp, 
	o_b6		=> B6temp, 
	o_b7		=> B7temp, 
	o_b8		=> B8temp, 
	o_win		=> Win_i1temp,
	o_count		=> count_itemp,
	rst			=> ResetAll_Top,
	clk			=> clk_o
	);

detik : CLOCKDIV port map (CLK => CLOCK_50, DIVOUT => clk_o);

Button_1_Top 	<= NOT SW(0);             
Button_2_Top 	<= NOT SW(1);               
ResetGame_Top 	<= SW(2);                
ResetAll_Top	<= SW(3);   
ledtest2		<= LEDR(1);

END behavioral; 