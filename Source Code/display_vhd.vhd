LIBRARY  IEEE; 
USE  IEEE.STD_LOGIC_1164.ALL; 
USE  IEEE.STD_LOGIC_ARITH.ALL; 
USE  IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY display_vhd  IS 
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
END display_vhd; 

ARCHITECTURE behavioral OF display_vhd  IS 

SIGNAL  red                 :        STD_LOGIC_VECTOR (5 DOWNTO 0);	  
SIGNAL  green               :        STD_LOGIC_VECTOR (5 DOWNTO 0);	  
SIGNAL  blue                :        STD_LOGIC_VECTOR (5 DOWNTO 0);	  
SIGNAL  red_color           :        STD_LOGIC_VECTOR (7 DOWNTO 0);   
SIGNAL  green_color         :        STD_LOGIC_VECTOR (7 DOWNTO 0);   
SIGNAL  blue_color          :        STD_LOGIC_VECTOR (7 DOWNTO 0);   
SIGNAL  pixel_row           :        STD_LOGIC_VECTOR (9 DOWNTO 0);   
SIGNAL  pixel_column        :        STD_LOGIC_VECTOR (9 DOWNTO 0);               
SIGNAL  red_on              :        STD_LOGIC;              
SIGNAL  green_on            :        STD_LOGIC;              
SIGNAL  blue_on             :        STD_LOGIC;              




COMPONENT vga  IS 
	PORT( 
		i_clk              :  IN   STD_LOGIC; 
		i_red              :  IN   STD_LOGIC; 
		i_green            :  IN   STD_LOGIC; 
		i_blue             :  IN   STD_LOGIC; 
		o_red              :  OUT  STD_LOGIC; 
		o_green            :  OUT  STD_LOGIC; 
		o_blue             :  OUT  STD_LOGIC;  
		o_horiz_sync       :  OUT  STD_LOGIC; 
		o_vert_sync        :  OUT  STD_LOGIC; 
		o_pixel_row        :  OUT  STD_LOGIC_VECTOR( 9 DOWNTO 0 ); 
		o_pixel_column     :  OUT  STD_LOGIC_VECTOR( 9 DOWNTO 0 )); 
END COMPONENT;  

COMPONENT color_rom_vhd  IS 
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
		Win_i1       	: IN STD_LOGIC_VECTOR (1 downto 0);
		count_i		  	: IN STD_LOGIC_VECTOR (3 downto 0);
	    i_pixel_column  : IN STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	    i_pixel_row     : IN STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	    o_red           : OUT STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	    o_green         : OUT STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	    o_blue          : OUT STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	    ledtest			: OUT STD_LOGIC);
END COMPONENT;  

BEGIN 

vga_driver0 : vga 
   PORT MAP (
   i_clk            => i_clk,
   i_red            => '1',
   i_green          => '1',
   i_blue           => '1',
   o_red            => red_on,
   o_green          => green_on,
   o_blue           => blue_on,
   o_horiz_sync     => VGA_HS,
   o_vert_sync      => VGA_VS,
   o_pixel_row      => pixel_row,
   o_pixel_column   => pixel_column);

color_rom0 : color_rom_vhd 
   PORT MAP (
	Button_1_i    	=> Button_1_i_disp,
	Button_2_i		=> Button_1_i_disp,
	ResetGame_i		=> ResetGame_i_disp,
	ResetAll_i		=> ResetAll_i_disp,
	B0_i			=> B0_i_disp,
	B1_i			=> B1_i_disp,
	B2_i			=> B2_i_disp,
	B3_i			=> B3_i_disp,
	B4_i			=> B4_i_disp,
	B5_i			=> B5_i_disp,
	B6_i			=> B6_i_disp,
	B7_i			=> B7_i_disp,
	B8_i			=> B8_i_disp,
	Win_i1       	=> Win_i1_disp,
	count_i		  	=> count_i_disp,
    i_pixel_column   => pixel_column,
    i_pixel_row      => pixel_row,
    o_red            => red_color,
    o_green          => green_color,
    o_blue           => blue_color,
    ledtest   		 => ledtest1
    );
   
red   <= red_color  (7 DOWNTO 2) ;
green <= green_color(7 DOWNTO 2) ;
blue  <= blue_color (7 DOWNTO 2) ;


PROCESS(red_on,green_on,blue_on,red,green,blue)
BEGIN

  IF (red_on = '1'  ) THEN VGA_R <=  red;
  ELSE  VGA_R <=  "000000";
  END IF;
  
  IF (green_on = '1'  ) THEN VGA_G <=  green;
  ELSE VGA_G <=  "000000";
  END IF;
  
  IF (blue_on = '1'  ) THEN VGA_B <=  blue;
  ELSE VGA_B <=  "000000";
  END IF;
  
  
END PROCESS;



END behavioral; 