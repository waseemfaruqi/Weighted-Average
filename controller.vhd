library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity controller is 
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
		
end controller;

architecture behavoral of controller is 
	type 		state is (rst, ready_state, sum, mul, div, done_state);
	signal 	current_state, next_state: state;
	signal	counter	: integer range 0 to 31;
begin
	
	process(clock, reset)
	begin
		if reset = '1' then
			current_state <= rst;
		elsif rising_edge(clock) and start = '1' then
			current_state <= next_state;
		end if;	
	end process;
	
	process(grades, current_state)
	begin
		case current_state is
			when rst		=>
				next_state 	<= ready_state;
				sum_enable	<= '0';
				mul_enable	<= '0';
				opcode		<= "00";
				data_sel_1	<= '0';
				data_sel_2	<=	'0';
				data_sel_3	<=	'0';
				done			<= '0';
				counter		<=	0;
				ready			<= '0';
			
			when ready_state	=>
				next_state  <= mul;
				sum_enable	<= '0';
				mul_enable	<= '0';
				opcode		<= "00";
				data_sel_1	<= '0';
				data_sel_2	<=	'0';
				data_sel_3	<=	'0';
				done			<= '0';
				counter		<=	 0 ;
				ready			<= '1';
			
			when mul		=>
				next_state  <= sum;
				sum_enable	<= '0';
				mul_enable	<= '1';
				opcode		<= "01";
				data_sel_1	<= '0';
				data_sel_2	<=	'0';
				data_sel_3	<=	'0';
				done			<= '0';
				
				ready			<= '1';
			
			when sum		=>
				if grades = x"FFFF" then
					next_state <= div;
				else
					next_state <= mul;
				end if;
				
				sum_enable	<= '1';
				mul_enable	<= '0';
				opcode		<= "00";
				data_sel_1	<= '1';
				data_sel_2	<=	'1';
				data_sel_3	<=	'0';
				done			<= '0';
				counter		<=	counter + 1;
				--counter		<= counter;
				--number		<=	std_logic_vector(to_signed(counter, number'length));
				ready			<= '1';
				
			when div 	=> 
				next_state  <= done_state;
				sum_enable	<= '0';
				mul_enable	<= '0';
				opcode		<= "10";
				data_sel_1	<= '1';
				data_sel_2	<=	'1';
				data_sel_3	<=	'1';
				done			<= '0';
				--counter		<= counter;
				number		<=	std_logic_vector(to_signed(counter, number'length));
				ready			<= '1';
			when done_state	=>
				sum_enable	<= '0';
				mul_enable	<= '0';
				--opcode		<= "00";
				data_sel_1	<= '1';
				data_sel_2	<=	'1';
				data_sel_3	<=	'1';
				done			<= '1';
				--counter		<= counter;
				--number		<=	std_logic_vector(to_signed(counter, number'length));
				ready			<= '1';
			when others	=>
				sum_enable	<= 'X';
				mul_enable	<= 'X';
				opcode		<= "XX";
				data_sel_1	<= 'X';
				data_sel_2	<=	'X';
				data_sel_3	<=	'X';
				done			<= 'X';
				counter		<= 0;
				number		<=	"XXXXXXXXXXXXXXXX";
				ready			<= 'X';
		end case;
	end process;
	
	
	
end behavoral;