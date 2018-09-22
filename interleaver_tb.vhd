library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity interleaver_tb is
end interleaver_tb;

architecture  inter_test_arch of interleaver_tb is
component interleaver 
port( 

data_input : in std_logic;
ready,clk,reset : in std_logic;
data_output,valid : out std_logic
);
end component;

signal clk : std_logic := '1';
signal data_input,data_output,valid,ready,reset : std_logic;
signal hexout : std_logic_vector( 0 to 191 ):= (others=>'0') ;
signal hexin : std_logic_vector( 0 to 191) := x"2833E48D392026D5B6DC5E4AF47ADD29494B6C89151348CA" ;

begin 

dut : interleaver 
port map(

clk => clk,
reset => reset,
valid => valid,
ready => ready, 
data_input => data_input,
data_output => data_output );

clk <= not clk after 50 ns;

stimulus : process 
begin

reset <= '1';

ready <= '0';

wait for 100 ns;

reset<='0';
ready <= '1';


for i in 0 to 191 loop
wait for 100 ns;

data_input <= hexin(i);

end loop ;
wait for 200 ns;

for i in 0 to 191 loop
wait for 100 ns;

hexout(i) <= data_output;

end loop ;

wait;

end process stimulus ;
end inter_test_arch;

