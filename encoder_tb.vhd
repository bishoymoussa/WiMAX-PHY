library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity encoder_tb is 
end encoder_tb;

architecture encoder_test_arch of encoder_tb is 

component encoder 
port( 

data_in : in std_logic ;
clk,reset,ready : in std_logic;
data_out : out std_logic;
valid: out std_logic
);

end component;

signal data_in,reset,ready,data_out,valid : std_logic ;
signal clk : std_logic := '1';
signal hexin : std_logic_vector( 0 to 95) := x"558AC4A53A1724E163AC2BF9" ;
signal hexout : std_logic_vector( 0 to 191 ):= (others=>'0') ;

begin

dut : encoder
 port map ( 

clk => clk,
reset => reset,
data_in =>data_in ,
data_out => data_out,
ready => ready,
valid => valid ) ;

clk <= not clk after 50 ns;

stimulus : process 
begin

reset <= '1';

ready <= '0';

wait for 100 ns;

reset<='0';
ready <= '1';
data_in <= hexin(0);
wait for 110 ns;
hexout(0) <= data_out;
data_in <= hexin(1);

for i in 0 to 93 loop
wait for 100 ns;
hexout(i+1) <= data_out;
data_in <= hexin(i+2);

end loop ;
for i in 94 to 190 loop
wait for 100 ns;
hexout(i+1) <= data_out;

end loop;


wait;

end process stimulus ;

end encoder_test_arch;

