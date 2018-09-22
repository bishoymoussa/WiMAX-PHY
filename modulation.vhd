library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modulation is 
port(

input,clk: in std_logic;
output1,output2: out signed( 15 downto 0 );
enable,reset: in std_logic;
valid: out std_logic
);

end modulation;


architecture modul_arch of modulation is

signal counter: unsigned( 2 downto 0);
signal b : std_logic_vector( 1 downto 0);
constant seven : signed(15 downto 0 ) := x"5A7F";
constant seven_negative : signed(15 downto 0 ) := x"A581";

begin 

process(clk,reset) 
begin

if(reset = '1') then
	counter <= "000";
elsif( clk'event and clk = '1' ) then
	if( enable = '1' ) then
		counter <= counter +1;
		b <= input & b(1);
	end if;
end if;
if(counter = "010")then
counter <= "000";
end if;

end process;



output1 <= seven when( b(0) = '0' and b(1) = '0' and counter = "010" ) else
  seven_negative when( b(0) = '0' and b(1) = '1'  and counter = "010" ) else
 seven when( b(0) = '1' and b(1) = '0'  and counter = "010" ) else
  seven_negative when( b(0) = '1' and b(1) = '1'  and counter = "010" );


output2 <= seven when( b(0) = '0' and b(1) = '0' and counter = "010" ) else
 seven when( b(0) = '0' and b(1) = '1'  and counter = "010" )else 
seven_negative when( b(0) = '1' and b(1) = '0'  and counter = "010" )else
  seven_negative when( b(0) = '1' and b(1) = '1'  and counter = "010" );

valid <= '1' when( counter = "010" ) else '0' ;

end modul_arch;
