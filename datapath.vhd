library ieee;
use ieee.std_logic_1164.all;

entity datapath is 
		port (
			grades		: in 	std_logic_vector 	(15 downto 0);
			weight		: in 	std_logic_vector 	(15 downto 0);
			number		: in  std_logic_vector	(15 downto 0);
			data_sel_1	: in	std_logic							 ;
			data_sel_2	: in  std_logic							 ;
			data_sel_3	: in  std_logic							 ;
			opcode		: in	std_logic_vector	( 1 downto 0);
			result_out	: out std_logic_vector	(15 downto 0);
			clock			: in  std_logic							 ;
			reset			: in  std_logic							 ;
			done			: in  std_logic							 ;
			sum_enable	: in  std_logic							 ;
			mul_enable	: in  std_logic
		);
		
end datapath;

architecture behavoral of datapath is

component mux_16 port(
						data_1 	: in 	std_logic_vector (15 downto 0);
						data_2 	: in 	std_logic_vector (15 downto 0);
						sel		: in 	std_logic							;
						data_out : out std_logic_vector(15 downto 0)
						); 
end component;

component register_16 
		port (
			data_in	: in std_logic_vector (15 downto 0); 
			enable 	: in std_logic;
			reset		: in std_logic;
			clock 	: in std_logic; 
			data_out : out std_logic_vector (15 downto 0)
		);
end component; 

component alu
	port( 	
			a,b 		: in 	std_logic_vector(15 downto 0);
			opcode 	: in 	std_logic_vector(	1 downto 0);
			res		: out std_logic_vector(15 downto 0)
		);
end component;

component buffer_16 
	port (
		data_in 	: in std_logic_vector (15 downto 0); 
		en 		: in std_logic; 
		data_out	: out std_logic_vector (15 downto 0)
		); 
end component; 

signal alu_out		: std_logic_vector (15 downto 0);
signal alu_a		: std_logic_vector (15 downto 0);
signal alu_b		: std_logic_vector (15 downto 0);
signal reg_out		: std_logic_vector (15 downto 0);
signal mux_wire	: std_logic_vector (15 downto 0);
signal reg2_out	: std_logic_vector (15 downto 0);

begin
	
	
	alu_in_1 : mux_16	
		port map(
			data_1 	=> grades,
			data_2 	=> reg_out,
			sel		=> data_sel_1,
			data_out => alu_a
		);
			
	alu_in_2_1 : mux_16
		port map(
			data_1 	=> weight,
			data_2 	=> mux_wire,
			sel		=> data_sel_2,
			data_out => alu_b
		);
	
	alu_in_2_2 : mux_16
		port map(
			data_1 	=> reg2_out,
			data_2 	=> number,
			sel		=> data_sel_3,
			data_out => mux_wire
		);
		
	AU			: alu 		 
		port map(
			a 			=> alu_a,
			b			=> alu_b,
			opcode	=> opcode,
			res		=> alu_out		
		);
	
	
	BUF_out	: buffer_16 
		port map(
			data_in 	=> alu_out,
			en 		=> done,
			data_out	=> result_out
		); 
	
	reg_sum	: register_16	
		port map(
			data_in	=>	alu_out, 
			enable 	=> sum_enable,
			reset		=> reset,
			clock 	=> clock,
			data_out => reg_out
		);
	
	reg_mul	: register_16	
		port map(
			data_in	=>	alu_out, 
			enable 	=> mul_enable,
			reset		=> reset,
			clock 	=> clock,
			data_out => reg2_out
		);
end behavoral;

