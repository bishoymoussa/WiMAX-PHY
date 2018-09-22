library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modulation_test is
end modulation_test;

architecture modulation_test_arch of modulation_test is

component modulation 
port(

input,clk: in std_logic;
output1,output2: out signed( 15 downto 0 );
enable,reset: in std_logic;
valid: out std_logic
); 

end component;

signal clk : std_logic := '1';
signal input,enable,valid,reset : std_logic;
signal output1,output2:  signed( 15 downto 0 );

signal hexin : std_logic_vector( 0 to 11) := x"4B0" ;

begin

dut : modulation
 port map ( 

clk => clk,
reset => reset,
input=>input ,
output1 =>output1 ,
output2 =>output2 ,
enable => enable,
valid => valid ) ;

clk <= not clk after 50 ns;



stimulus : process 
begin

reset <= '1';

enable <= '0';

wait for 100 ns;

reset<='0';
enable <= '1';

for i in 0 to 11 loop

input <= hexin(i);
wait for 100 ns;
end loop ;



wait;

end process stimulus ;

end modulation_test_arch;
