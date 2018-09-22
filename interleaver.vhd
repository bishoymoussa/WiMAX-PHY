library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity interleaver is 
port( 

data_input : in std_logic;
ready,clk,reset : in std_logic;
data_output,valid : out std_logic
);

end interleaver;

architecture interleaver_arch of interleaver is 

type interleaver_state is 
( filling_registers , reading_registers );
signal k1,counter : unsigned( 7 downto 0 );
signal shift_reg : std_logic_vector( 191 downto 0 );
signal mk1: unsigned( 8 downto 0 );
signal state_reg : interleaver_state;
signal data_input_delayed : std_logic;
constant sixteen: unsigned( 4 downto 0 ) := "10000";
constant twelve: unsigned( 3 downto 0 ) := "1100";
begin 

process( clk,reset ) 

variable index1,indx : integer:= 0;

begin 

if( reset = '1' ) then 
	shift_reg <= ( others => '0' );
	k1 <= ( others => '0' );
	counter <= "00000000";
	state_reg <= filling_registers;
	valid <= '0';

elsif( clk = '1' and clk'event ) then 

	if( ready = '1' ) then 

		data_input_delayed <= data_input;
		
		case state_reg is 

		when filling_registers => 
			
			valid <= '0';

 			 mk1 <=  ( twelve*(k1 mod sixteen ) )+ (k1/sixteen);
			
			k1 <= k1 + 1;
			

			index1 := to_integer(mk1);
			

			shift_reg(index1) <= data_input_delayed;
			
				
				if( k1 = "11000000" ) then 
					
					state_reg <= reading_registers;
				end if;
					

		when  reading_registers =>

			k1 <= ( others => '0' );
        		mk1 <= ( others => '0' );
		
			valid <= '1';
			indx := to_integer(counter);

			data_output <= shift_reg(indx);

			counter <= counter + 1;
				if( counter = "10111111" ) then
					counter <= "00000000";
					state_reg <= filling_registers;
				end if;

		end case;

	end if;

end if;





end process;

end interleaver_arch;



			