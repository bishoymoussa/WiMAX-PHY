library ieee;
use ieee.std_logic_1164.all;


entity prbs is
   port(
      clk, reset: in std_logic;
      datain : in std_logic;
      dataout,valid: out std_logic;
      load : in std_logic;
      en : in std_logic
   );
end prbs;

architecture randomer of prbs is
   signal r_reg: std_logic_vector( 14 downto 0 ) ; 
   signal r_next: std_logic_vector( 14 downto 0 );
   signal temp: std_logic;
begin
   -- register
   process(clk,reset)
   begin 
      if (reset='1') then
         r_reg <= (others=>'0');
         
      elsif (clk'event and clk='1') then
        
        if ( load = '1' ) then
         r_reg <= "101010001110110" ;
         
       elsif (  en = '1' ) then
       r_reg <= r_next ; 
       
    end if; 
    end if;
   end process;
   -- next-state logic (shift right 1 bit)
   temp <= r_reg(14) xor r_reg(13);
   r_next <=  r_reg(13 downto 0)& temp ;
   -- output
   dataout <= temp xor datain ;
valid <= '1' when ( en = '1'  ) ;
end randomer; 


