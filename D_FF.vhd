library ieee; 
use ieee.std_logic_1164.all; 

entity D_FF is 
port ( 
		D 			: in std_logic; 
		clock 	: in std_logic; 
		enable 	: in std_logic;
		reset		: in std_logic;
		Q 			: out std_logic 
		); 
end D_FF; 

architecture behavoral of D_FF is 
begin
	process(clock, reset) 
	begin
		if reset = '1' then 
			Q <= '0' after 2 ps;
		elsif clock'event  and clock = '1' and enable = '1'  then 
			Q<=D after 2 ps;   
		end if; 
	end process; 
end behavoral; 
