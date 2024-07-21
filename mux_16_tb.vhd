library ieee;
use ieee.std_logic_1164.all;


entity mux_16_tb is
end mux_16_tb;

architecture tb of mux_16_tb is
	signal start		: std_logic;
	signal grades		: std_logic_vector (15 downto 0);
	signal weight		: std_logic_vector (15 downto 0);
	signal res_out		: std_logic_vector (15 downto 0);
	signal clock		: std_logic			 			 	  ;
	signal done			: std_logic							  ;
	signal ready		: std_logic							  ;
begin
   UUT :entity work.average 
	port map(
		start		=> start,
		clock		=> clock,
		grades	=> grades,
		weight	=> weight,
		ready		=> ready,
		done		=> done,
		res_out	=> res_out
		);
	
	start_proc : process
	begin
		start 		<= '0';
		wait for 20 ns;
		start		<= '1';
		wait;
	end process;
	
	mul_1 : process
	begin
	wait for 20 ns;
	 	
    grades  	<= x"0008";
	 weight  	<= x"0002";
	 
	 wait for 80 ns;
	 
	 grades  	<= x"0009";
	 weight  	<= x"0003";
	 
	wait for 80 ns;
	 
	 grades  	<= x"0005";
	 weight  	<= x"0006";
	wait for 80 ns;
		grades	<= x"FFFF";
	wait for 40 ns;
	 end process;
	 
	process
	begin
		clock <= '0';
		wait for 20 ns;
		clock <= '1';
		wait for 20 ns;
	end process;
	
end tb ;