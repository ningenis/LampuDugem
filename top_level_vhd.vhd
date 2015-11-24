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
	    LEDR       : OUT STD_LOGIC_VECTOR( 9 DOWNTO 0 ));
END top_level_vhd; 

ARCHITECTURE behavioral OF top_level_vhd  IS 
component dugem
	port (clock : IN STD_LOGIC; --Clock FPGA
		  reset : IN STD_LOGIC; --Tombol Reset
		  enter : IN STD_LOGIC; --Input Enter
		  lampu : OUT STD_LOGIC_VECTOR(3 downto 0));
end component; 
SIGNAL  M_US : STD_LOGIC;              
SIGNAL  K_US : STD_LOGIC;              
SIGNAL  H_US : STD_LOGIC;              
SIGNAL  M_BT : STD_LOGIC;              
SIGNAL  K_BT : STD_LOGIC;              
SIGNAL  H_BT : STD_LOGIC;              
SIGNAL	lights: STD_LOGIC_VECTOR(5 downto 0);           

COMPONENT display_vhd  IS 
	PORT( 
	    i_clk           : IN STD_LOGIC;                                  
	    i_M_US          : IN STD_LOGIC;
	    i_K_US          : IN STD_LOGIC;
	    i_H_US          : IN STD_LOGIC;
	    i_M_BT          : IN STD_LOGIC;
	    i_K_BT          : IN STD_LOGIC;
	    i_H_BT          : IN STD_LOGIC;
	    VGA_R           : OUT STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	    VGA_G           : OUT STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	    VGA_B           : OUT STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	    VGA_HS          : OUT STD_LOGIC;
	    VGA_VS          : OUT STD_LOGIC;
	    VGA_CLK         : OUT STD_LOGIC;
	    VGA_BLANK       : OUT STD_LOGIC);
END COMPONENT; 

BEGIN 

module_vga : display_vhd 
   PORT MAP (
   i_clk                =>  CLOCK_50,  
   i_M_US               =>  M_US,  
   i_K_US               =>  K_US,  
   i_H_US               =>  H_US,  
   i_M_BT               =>  M_BT,  
   i_K_BT               =>  K_BT,  
   i_H_BT               =>  H_BT,
   VGA_R                =>  VGA_R,  
   VGA_G                =>  VGA_G,  
   VGA_B                =>  VGA_B,
   VGA_HS               =>  VGA_HS,  
   VGA_VS               =>  VGA_VS,
   VGA_CLK              =>  VGA_CLK,
   VGA_BLANK            =>  VGA_BLANK
);
U2:Traffic
	PORT MAP (
	clock=>CLOCK_50,
	clr=>SW(0),
	enter=>SW(1),
	s=>SW(2),
	lights=>lights
	);
M_US <= lights(0) ;
K_US <= lights(1) ;
H_US <= lights(2) ;
M_BT <= lights(3) ;
K_BT <= lights(4) ;
H_BT <= lights(5) ;
END behavioral; 