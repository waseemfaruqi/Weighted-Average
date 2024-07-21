library ieee;
use ieee.std_logic_1164.all; 

entity mux_16 is 
				port(
						data_1 	: in std_logic_vector (15 downto 0);
						data_2 	: in std_logic_vector (15 downto 0);
						sel		: in std_logic							  ;
						data_out : out std_logic_vector(15 downto 0)
						); 
end mux_16;
 
architecture behavoral of mux_16 is
begin
	process (sel, data_1, data_2)
	begin 
		case sel is 
			when '0' => 
				data_out <= data_1;
			when '1' => 
				data_out <= data_2;
			when others => 
				data_out <=  "UUUUUUUUUUUUUUUU";
		end case; 
	end process; 
end behavoral; 
