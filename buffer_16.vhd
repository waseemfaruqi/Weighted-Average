library ieee;
use ieee.std_logic_1164.all; 

entity buffer_16 is 
port (
		data_in 	: in std_logic_vector (15 downto 0); 
		en 		: in std_logic; 
		data_out	: out std_logic_vector (15 downto 0)
		); 
end buffer_16; 

architecture behavoral of buffer_16 is 
	begin 

		data_out	<=	data_in after 1 ps when (en='1') else "ZZZZZZZZZZZZZZZZ" after 1 ps; 

	end behavoral; 
