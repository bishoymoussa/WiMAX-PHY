library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity encoder is 
port( 

data_in : in std_logic ;
clk,reset,ready : in std_logic;
data_out : out std_logic;
valid: out std_logic
);

end encoder;

architecture encoder_arch of encoder is

signal x,y : std_logic;
signal shift_reg : std_logic_vector( 5 downto 0 );
signal out_reg : std_logic_vector( 191 downto 0 );
signal counter,counter2,counter3: unsigned(7 downto 0);
signal flag : std_logic;

begin

process( clk,reset )
variable index1,index2,index3: integer:= 0;
begin 

if( reset = '1' ) then
	shift_reg <= "100111";
	counter<= "00000000";
	counter2<= "00000001";
	counter3<= "00000000";
	flag <= '0';
	out_reg <= ( others => '0' );
elsif( clk = '1' and clk'event ) then
	if(ready='1') then

		if( flag = '0' ) then 
			shift_reg <= data_in & shift_reg(5 downto 1);
			counter<= counter +2;
			counter2<= counter2 +2;
			counter3<= counter3 +1;
			index1 := to_integer(counter);
			index2 := to_integer(counter2);
			index3 := to_integer(counter3);
			out_reg(index1) <= x;
			out_reg(index2) <= y;

			data_out <= out_reg(index3);

		else 

		counter3<= counter3 +1;
		index3 := to_integer(counter3);
		data_out <= out_reg(index3);
		end if;
	end if;
	
	if(counter3 = "10111111" ) then

		counter<= "00000000";
		counter2<= "00000001";
		counter3 <= "00000000"; 
		flag<= '0';
	
	end if;

	if(counter2 = "10111111" ) then
		flag<= '1';
		counter2 <= "00000001";
	end if;
end if;


end process;

x <= data_in xor shift_reg(5) xor shift_reg(4) xor shift_reg(3) xor shift_reg(0) when(  ready = '1' );

y <= data_in xor shift_reg(4) xor shift_reg(3) xor shift_reg(1) xor shift_reg(0) when(  ready = '1' );




valid <= '1' when( ready ='1' and counter3 /= "00000000" ) else '0';

end encoder_arch;
