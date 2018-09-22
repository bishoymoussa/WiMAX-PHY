library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WiMAX is 

port( 

clk_system, reset_system: in std_logic;
      data_input_system : in std_logic;
      data_out_system,valid_system: out std_logic;
      load_system : in std_logic;
      enable_system : in std_logic
   );



end WiMAX;


architecture whymax_arch of WiMAX is 

component prbs is
   port(
      clk, reset: in std_logic;
      datain : in std_logic;
      dataout,valid: out std_logic;
      load : in std_logic;
      en : in std_logic
   );
end component;

component encoder is 
port( 

data_in : in std_logic ;
clk,reset,ready : in std_logic;
data_out : out std_logic;
valid: out std_logic
);

end component;

component interleaver is 
port( 

data_input : std_logic;
ready,clk,reset : in std_logic;
data_output,valid : out std_logic
);

end component;

signal data_out_rand_to_enc, valid_rand_to_enc: std_logic;
signal data_out_enc_to_inter, valid_enc_to_inter : std_logic;

begin 


u1: prbs port map( 

clk => clk_system,
reset=> reset_system,
load => load_system,
en => enable_system,
datain => data_input_system,
dataout => data_out_rand_to_enc,
valid => valid_rand_to_enc
);


u2: encoder port map( 

clk => clk_system,
reset=> reset_system,
ready => valid_rand_to_enc,
data_in => data_out_rand_to_enc,
data_out => data_out_enc_to_inter,
valid => valid_enc_to_inter
);

u3: inter port map(
clk => clk_system,
reset=> reset_system,
ready => valid_enc_to_inter,
data_input => data_out_enc_to_inter,
valid => valid_system,
data_output => data_out_system
);

end whymax_arch;

