library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity WiMAX_tb is 
end WiMAX_tb;

architecture WiMAX_tb_arch of WiMAX_tb is 

component WiMAX is 

port( 

clk_system, reset_system: in std_logic;
      data_input_system : in std_logic;
      data_out_system,valid_system: out std_logic;
      load_system : in std_logic;
      enable_system : in std_logic
   );



end component;

signal clktest : std_logic := '1' ;
  signal restest : std_logic ; 
  signal testin, loadtest, entest,valid : std_logic ;
  signal testout : std_logic ;
  signal hexin : std_logic_vector( 0 to 95) := x"ACBCD2114DAE1577C6DBF4C9" ;
  signal hexout : std_logic_vector( 0 to 191 ):= (others=>'0') ;

begin 
dut: WiMAX 
port map ( 

clk_system => clktest,
reset_system => restest,
load_system => loadtest,
enable_system => entest,
valid_system => valid,
data_input_system => testin,
data_out_system => testout
);

clktest <= not clktest after 50 ns;

stimulus : process 
begin 
restest <= '1';

entest <= '0';
wait for 100 ns ;
restest <= '0';
loadtest <= '1';
wait for 100 ns;
loadtest <= '0';
entest <= '1';
testin <= '1';

for i in 0 to 94 loop
wait for 100 ns ;
testin <= hexin(i +1);

end loop ;

wait for 10010 ns;

for i in 0 to 191 loop
wait for 100 ns;

hexout(i) <= testout;

end loop ;

wait for 100 ns;
hexout(191) <= testout;
wait;

end process stimulus ;

end WiMAX_tb_arch;
