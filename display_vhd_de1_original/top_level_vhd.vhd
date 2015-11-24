LIBRARY  IEEE; 
USE  IEEE.STD_LOGIC_1164.ALL; 
USE  IEEE.STD_LOGIC_ARITH.ALL; 
USE  IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY top_level_vhd  IS -- Entitas Top Level
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
component dugem -- Komponen Dugem dari FSM
	port (clock: IN STD_LOGIC;
		  reset: IN STD_LOGIC;
		  enter: IN STD_LOGIC;
		  lampu: OUT STD_LOGIC_VECTOR(2 downto 0));
end component; 

SIGNAL  M_US : STD_LOGIC; -- Sinyal Warna Lampu            
SIGNAL  K_US : STD_LOGIC;              
SIGNAL  H_US : STD_LOGIC;        
SIGNAL  M_BT : STD_LOGIC;            
SIGNAL  K_BT : STD_LOGIC;              
SIGNAL  H_BT : STD_LOGIC;                 
SIGNAL	lampu: STD_LOGIC_VECTOR(2 downto 0);            

COMPONENT display_vhd  IS -- Komponen Display
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

module_vga : display_vhd -- Port Komponen dari Display.vhd
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
U2:dugem --Port Komponen dari FSM Lampu Dugem
	PORT MAP (
	clock=>CLOCK_50,
	reset=>SW(1),
	enter=>SW(0),
	lampu=>lampu
	);
M_US <= lampu(0);
M_BT <= lampu(0);
K_US <= lampu(1);
K_BT <= lampu(1);
H_US <= lampu(2);
H_BT <= lampu(2);

END behavioral; 