library ieee;
use ieee.std_logic_1164.all;

entity prbs_tb is 
end prbs_tb;

architecture prbs_tb_arch of prbs_tb is 

component prbs 
port ( 
  clk, reset: in std_logic;
      datain : in std_logic;
      dataout,valid: out std_logic;
      load : in std_logic;
      en : in std_logic
    ); 
    
  end component ; 
  
  signal clktest : std_logic := '1' ;
  signal restest : std_logic ; 
  signal testin, loadtest, entest,valid : std_logic ;
  signal testout : std_logic ;
  signal hexin : std_logic_vector( 0 to 95) := x"ACBCD2114DAE1577C6DBF4C9" ;
  signal hexout : std_logic_vector( 0 to 95 ):= (others=>'0') ;

begin 
dut : prbs
 port map ( 

clk => clktest,
reset => restest,
datain => testin,
dataout => testout,
valid => valid,
load => loadtest,
en => entest ) ;


clktest <= not clktest after 20 ns;


stimulus : process 
begin 
restest <= '1';

entest <= '0';
wait for 40 ns ;
restest <= '0';
loadtest <= '1';
wait for 40 ns;
loadtest <= '0';
entest <= '1';
testin <= '1';

for i in 0 to 94 loop
wait for 40 ns ;
testin <= hexin(i +1);
hexout(i) <= testout;

end loop ;


wait for 40 ns;
hexout(95) <= testout;
wait;
end process stimulus ;

end prbs_tb_arch;


