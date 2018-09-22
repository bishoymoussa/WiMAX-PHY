library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FFT128 is
port(Clk : in std_logic;
     Rst : in std_logic);
end entity FFT128;

architecture rtl of FFT128 is
component FFT is
		port (
			clk          : in  std_logic                     := 'X';             -- clk
			reset_n      : in  std_logic                     := 'X';             -- reset_n
			sink_valid   : in  std_logic                     := 'X';             -- sink_valid
			sink_ready   : out std_logic;                                        -- sink_ready
			sink_error   : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- sink_error
			sink_sop     : in  std_logic                     := 'X';             -- sink_sop
			sink_eop     : in  std_logic                     := 'X';             -- sink_eop
			sink_real    : in  std_logic_vector(15 downto 0) := (others => 'X'); -- sink_real
			sink_imag    : in  std_logic_vector(15 downto 0) := (others => 'X'); -- sink_imag
			inverse      : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- inverse
			source_valid : out std_logic;                                        -- source_valid
			source_ready : in  std_logic                     := 'X';             -- source_ready
			source_error : out std_logic_vector(1 downto 0);                     -- source_error
			source_sop   : out std_logic;                                        -- source_sop
			source_eop   : out std_logic;                                        -- source_eop
			source_real  : out std_logic_vector(15 downto 0);                    -- source_real
			source_imag  : out std_logic_vector(15 downto 0);                    -- source_imag
			source_exp   : out std_logic_vector(5 downto 0)                      -- source_exp
		);
	end component FFT;
	
	component Real_input IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
	END component;
	
	component Img_input IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
END component;

	signal address_sig		: STD_LOGIC_VECTOR (7 DOWNTO 0);
	signal data_sig_img		: STD_LOGIC_VECTOR (15 DOWNTO 0);
	signal data_sig_real		: STD_LOGIC_VECTOR (15 DOWNTO 0);
	signal rden_sig			:  STD_LOGIC  := '1';
	signal wren_sig			: std_logic ;
	
	signal sink_error     : std_logic_vector(1 downto 0);  -- FFT_inst_sink_bfm:sig_sink_error -> FFT_inst:sink_error
	signal inverse        : std_logic_vector(0 downto 0);  -- FFT_inst_sink_bfm:sig_inverse -> FFT_inst:inverse
	signal sink_eop       : std_logic_vector(0 downto 0);  -- FFT_inst_sink_bfm:sig_sink_eop -> FFT_inst:sink_eop
	signal sink_sop       : std_logic_vector(0 downto 0);  -- FFT_inst_sink_bfm:sig_sink_sop -> FFT_inst:sink_sop
	signal sink_valid     : std_logic_vector(0 downto 0);  -- FFT_inst_sink_bfm:sig_sink_valid -> FFT_inst:sink_valid
	signal sink_real      : std_logic_vector(15 downto 0); -- FFT_inst_sink_bfm:sig_sink_real -> FFT_inst:sink_real
	signal sink_ready                 : std_logic;                     -- FFT_inst:sink_ready -> FFT_inst_sink_bfm:sig_sink_ready
	signal sink_imag      : std_logic_vector(15 downto 0); -- FFT_inst_sink_bfm:sig_sink_imag -> FFT_inst:sink_imag
	signal source_imag              : std_logic_vector(15 downto 0); -- FFT_inst:source_imag -> FFT_inst_source_bfm:sig_source_imag
	signal source_real              : std_logic_vector(15 downto 0); -- FFT_inst:source_real -> FFT_inst_source_bfm:sig_source_real
	signal source_ready : std_logic;  -- FFT_inst_source_bfm:sig_source_ready -> FFT_inst:source_ready
	signal source_sop               : std_logic;                     -- FFT_inst:source_sop -> FFT_inst_source_bfm:sig_source_sop
	signal source_eop               : std_logic;                     -- FFT_inst:source_eop -> FFT_inst_source_bfm:sig_source_eop
	signal source_valid             : std_logic;                     -- FFT_inst:source_valid -> FFT_inst_source_bfm:sig_source_valid
	signal source_exp               : std_logic_vector(5 downto 0);  -- FFT_inst:source_exp -> FFT_inst_source_bfm:sig_source_exp
	signal source_error             : std_logic_vector(1 downto 0);  -- FFT_inst:source_error -> FFT_inst_source_bfm:sig_source_error

	type FFT_state_type is
        (idle, FFT_input, FFT_EOP_wait, FFT_EOP_wait_wait, FFT_EOP, output_Latancy, output_recieve);
   signal state_reg, state_next: FFT_state_type;
	
begin

	fft_inst : component FFT
		port map (
			clk          => Clk,                    --    clk.clk
			reset_n      => Rst,                --    rst.reset_n
			sink_valid   => sink_valid(0),     --   sink.sink_valid
			sink_ready   => sink_ready,                    --       .sink_ready
			sink_error   => sink_error,        --       .sink_error
			sink_sop     => sink_sop(0),       --       .sink_sop
			sink_eop     => sink_eop(0),       --       .sink_eop
			sink_real    => sink_real,         --       .sink_real
			sink_imag    => sink_imag,         --       .sink_imag
			inverse      => inverse,           --       .inverse
			source_valid => source_valid,                -- source.source_valid
			source_ready => source_ready, --       .source_ready
			source_error => source_error,                --       .source_error
			source_sop   => source_sop,                  --       .source_sop
			source_eop   => source_eop,                  --       .source_eop
			source_real  => source_real,                 --       .source_real
			source_imag  => source_imag,                 --       .source_imag
			source_exp   => source_exp                   --       .source_exp
		);
		
		Img_input_inst : Img_input PORT MAP (
		address	 => address_sig(6 downto 0),
		clock	 => Clk,
		data	 => data_sig_img,
		rden	 => rden_sig,
		wren	 => wren_sig,
		q	 => sink_imag
		);
		
		Real_input_inst : Real_input PORT MAP (
		address	 => address_sig(6 downto 0),
		clock	 => Clk,
		data	 => data_sig_real,
		rden	 => rden_sig,
		wren	 => wren_sig,
		q	 => sink_real
	   );
		
		-- state register
   process(Clk,Rst)
   begin
      if (Rst='0') then
         state_reg <= idle;
      elsif (Clk'event and Clk='1') then
         state_reg <= state_next;
      end if;
   end process;
	
	-- next-state logic and output logic
   process(state_reg,address_sig,sink_ready,source_valid)
   begin
			sink_valid <= "0";
			sink_sop <= "0"; 
			rden_sig <= '0';
			inverse <= "1";
			sink_eop <= "0";
			source_ready <= '1';
			sink_error <= "00";
      case state_reg is
         when idle =>
				rden_sig <= '1';
            if sink_ready='1' then 
               state_next <= FFT_input;
				else
					state_next <= idle;
            end if;
         when FFT_input =>
				rden_sig <= '1';
				if address_sig = "00000010"then
					sink_sop <= "1";
				end if;
				if address_sig = "01111111" then
					state_next <= FFT_EOP_wait;
				else
					state_next <= FFT_input;
				end if;
				if address_sig >= "00000010"then
					sink_valid <= "1";
				end if;
			when FFT_EOP_wait =>
				sink_valid <= "1";
				state_next <= FFT_EOP;
			when FFT_EOP => 
				sink_eop <= "1";
				sink_valid <= "1";
				state_next <= output_Latancy;
			when output_Latancy =>
				if(source_valid = '1')then
					state_next <= output_recieve;
				else
					state_next <= output_Latancy; 
				end if;
				
			when output_recieve =>
				if(source_valid = '0')then
					state_next <= idle;
				else
					state_next <= output_recieve;
				end if;
				
			when others =>
				state_next <= idle;
      end case;
   end process; 
	 
	
	address_increment:process(Clk,Rst)
	begin
		if Rst = '0' then
			address_sig <= (others=>'0'); 
		elsif rising_edge(Clk) then
			if(rden_sig = '1' and sink_ready='1')then
				address_sig <= std_logic_vector(unsigned(address_sig) + 1);
			end if;
		end if;
	
	end process;
	
	
end architecture rtl; -- of FFT_tb