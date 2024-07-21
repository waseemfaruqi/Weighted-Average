library ieee;
use ieee.std_logic_1164.all; 

entity average is 
port (
		start		: in  std_logic;
		clock		: in  std_logic;
		grades	: in  std_logic_vector(15 downto 0);
		weight	: in  std_logic_vector(15 downto 0);
		ready		: out std_logic;
		done		: out std_logic;
		res_out	: out std_logic_vector(15 downto 0)
		);

end average;
		
architecture behavoral of average is

	
	component controller is 
		port (
			grades		: in 	std_logic_vector 	(15 downto 0);
			start 		: in 	std_logic;
			clock			: in 	std_logic;
			reset			: in 	std_logic;
			ready			: out std_logic;
			number		: out std_logic_vector	(15 downto 0);
			data_sel_1	: out	std_logic;
			data_sel_2	: out std_logic;
			data_sel_3	: out std_logic;
			opcode		: out	std_logic_vector	( 1 downto 0);
			done			: out std_logic;
			sum_enable	: out std_logic;
			mul_enable	: out std_logic
		);
		
	end component;
	
	component datapath is 
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
		
	end component;
	
	signal number		: std_logic_vector	(15 downto 0);
	signal data_sel_1	: std_logic;
	signal data_sel_2	: std_logic;
	signal data_sel_3	: std_logic;
	signal opcode		: std_logic_vector	( 1 downto 0);
	signal sum_enable	: std_logic;
	signal mul_enable	: std_logic;
	signal done_wire	: std_logic;
begin

	C : controller 
		port map(
			grades		=> grades,
			start 		=> start,
			clock			=> clock,
			ready			=> ready,
			number		=> number,
			reset			=> '0',
			data_sel_1	=> data_sel_1,
			data_sel_2	=> data_sel_2,
			data_sel_3	=> data_sel_3,
			opcode		=> opcode,
			done			=> done_wire,
			sum_enable	=> sum_enable,
			mul_enable	=> mul_enable
		);
		
	D : datapath 
		port map (
			grades		=> grades,
			weight		=> weight,
			reset			=> '0',
			number		=> number,
			data_sel_1	=> data_sel_1,
			data_sel_2	=> data_sel_2,
			data_sel_3	=> data_sel_3,
			opcode		=> opcode,
			result_out	=> res_out,
			clock			=> clock,
			done			=> done_wire,
			sum_enable	=> sum_enable,
			mul_enable	=> mul_enable
		);
	
	done <= done_wire;
	
end behavoral;