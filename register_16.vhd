library ieee; 
use ieee.std_logic_1164.all; 

entity register_16 is 
port (
		data_in	: in std_logic_vector (15 downto 0); 
		enable 	: in std_logic;
		reset		: in std_logic;
		clock 	: in std_logic; 
		data_out : out std_logic_vector (15 downto 0)
		);
end register_16; 

architecture behavoral of register_16 is 

component D_FF
	port ( 
			D 			: in std_logic; 
			clock 	: in std_logic; 
			enable 	: in std_logic;
			reset		: in std_logic;
			Q 			: out std_logic 
);
end component; 

begin
		flip_flop 		: for i in 0 to 15 generate 
			one_bit	 	: D_FF
						  port map (D			=>	data_in(i),
										clock		=> clock,
										enable	=> enable,
										reset		=> reset,
										Q			=> data_out(i)); 
		end generate; 

end behavoral;


