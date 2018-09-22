-- (C) 2001-2017 Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions and other 
-- software and tools, and its AMPP partner logic functions, and any output 
-- files any of the foregoing (including device programming or simulation 
-- files), and any associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License Subscription 
-- Agreement, Intel MegaCore Function License Agreement, or other applicable 
-- license agreement, including, without limitation, that your use is for the 
-- sole purpose of programming logic devices manufactured by Intel and sold by 
-- Intel or its authorized distributors.  Please refer to the applicable 
-- agreement for further details.


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--  version		: $Version:	1.0 $ 
--  revision		: $Revision: #1 $ 
--  designer name  	: $Author: swbranch $ 
--  company name   	: altera corp.
--  company address	: 101 innovation drive
--                  	  san jose, california 95134
--                  	  u.s.a.
-- 
--  copyright altera corp. 2003
-- 
-- 
--  $Header: //acds/rel/17.0std/ip/dsp/altera_fft_ii/src/rtl/lib/old_arch/asj_fft_alt_shift_tdl.vhd#1 $ 
--  $log$ 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- megafunction wizard: %ALTSHIFT_TAPS%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: altshift_taps 

-- ============================================================
-- File Name: alt_shift_tdl.vhd
-- Megafunction Name(s):
-- 			altshift_taps
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 4.0 Internal Build 173 12/03/2003 SJ Full Version
-- ************************************************************


--Copyright (C) 1991-2004 Altera Corporation
--Any  megafunction  design,  and related netlist (encrypted  or  decrypted),
--support information,  device programming or simulation file,  and any other
--associated  documentation or information  provided by  Altera  or a partner
--under  Altera's   Megafunction   Partnership   Program  may  be  used  only
--to program  PLD  devices (but not masked  PLD  devices) from  Altera.   Any
--other  use  of such  megafunction  design,  netlist,  support  information,
--device programming or simulation file,  or any other  related documentation
--or information  is prohibited  for  any  other purpose,  including, but not
--limited to  modification,  reverse engineering,  de-compiling, or use  with
--any other  silicon devices,  unless such use is  explicitly  licensed under
--a separate agreement with  Altera  or a megafunction partner.  Title to the
--intellectual property,  including patents,  copyrights,  trademarks,  trade
--secrets,  or maskworks,  embodied in any such megafunction design, netlist,
--support  information,  device programming or simulation file,  or any other
--related documentation or information provided by  Altera  or a megafunction
--partner, remains with Altera, the megafunction partner, or their respective
--licensors. No other licenses, including any licenses needed under any third
--party's intellectual property, are provided herein.

-------------------------------------------------------------------------------------------
-- 
-------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

use work.fft_pack.all;
library lpm;
use lpm.lpm_components.all;
library altera_mf;
use altera_mf.altera_mf_components.all;

-------------------------------------------------------------------------------------------
-- Implements a Delay Line for both data and Control on buses of length MPR
-------------------------------------------------------------------------------------------

ENTITY asj_fft_alt_shift_tdl IS
	GENERIC
	(
		mpr :   integer:=8;
		depth : integer:=4;
		m512 :  integer:=1
	);
	PORT
	(
global_clock_enable : in std_logic;
		shiftin		: IN STD_LOGIC_VECTOR ( mpr-1 DOWNTO 0);
		clock		: IN STD_LOGIC ;
		shiftout		: OUT STD_LOGIC_VECTOR (mpr-1 DOWNTO 0);
		taps		: OUT STD_LOGIC_VECTOR (mpr-1 DOWNTO 0)
	);
END asj_fft_alt_shift_tdl;


ARCHITECTURE SYN OF asj_fft_alt_shift_tdl IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (mpr-1 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC_VECTOR (mpr-1 DOWNTO 0);



	COMPONENT altshift_taps
	GENERIC (
		width		: NATURAL;
		number_of_taps		: NATURAL;
		tap_distance		: NATURAL;
		lpm_hint		: STRING;
		lpm_type		: STRING
	);
	PORT (
clken : in std_logic;
			taps	: OUT STD_LOGIC_VECTOR (mpr-1 DOWNTO 0);
			clock	: IN STD_LOGIC ;
			shiftout	: OUT STD_LOGIC_VECTOR (mpr-1 DOWNTO 0);
			shiftin	: IN STD_LOGIC_VECTOR (mpr-1 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	taps    <= sub_wire0(mpr-1 DOWNTO 0);
	shiftout    <= sub_wire1(mpr-1 DOWNTO 0);

	altshift_taps_component : altshift_taps
	GENERIC MAP (
		width => mpr,
		number_of_taps => 1,
		tap_distance => depth,
		lpm_hint => "RAM_BLOCK_TYPE=M512",
		lpm_type => "altshift_taps"
	)
	PORT MAP (
clken => global_clock_enable,
		clock => clock,
		shiftin => shiftin,
		taps => sub_wire0,
		shiftout => sub_wire1
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: WIDTH NUMERIC "8"
-- Retrieval info: PRIVATE: NUMBER_OF_TAPS NUMERIC "1"
-- Retrieval info: PRIVATE: TAP_DISTANCE NUMERIC "8"
-- Retrieval info: PRIVATE: GROUP_TAPS NUMERIC "0"
-- Retrieval info: PRIVATE: CLKEN NUMERIC "0"
-- Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
-- Retrieval info: PRIVATE: MEGAFN_PORT_INFO_0 STRING "shiftin;clock;clken;shiftout;taps"
-- Retrieval info: CONSTANT: WIDTH NUMERIC "8"
-- Retrieval info: CONSTANT: NUMBER_OF_TAPS NUMERIC "1"
-- Retrieval info: CONSTANT: TAP_DISTANCE NUMERIC "8"
-- Retrieval info: CONSTANT: LPM_HINT STRING "RAM_BLOCK_TYPE=M512"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "altshift_taps"
-- Retrieval info: USED_PORT: shiftin 0 0 8 0 INPUT NODEFVAL shiftin[7..0]
-- Retrieval info: USED_PORT: shiftout 0 0 8 0 OUTPUT NODEFVAL shiftout[7..0]
-- Retrieval info: USED_PORT: taps 0 0 8 0 OUTPUT NODEFVAL taps[7..0]
-- Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL clock
-- Retrieval info: CONNECT: @shiftin 0 0 8 0 shiftin 0 0 8 0
-- Retrieval info: CONNECT: shiftout 0 0 8 0 @shiftout 0 0 8 0
-- Retrieval info: CONNECT: taps 0 0 8 0 @taps 0 0 8 0
-- Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
-- Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
-- Retrieval info: GEN_FILE: TYPE_NORMAL alt_shift_tdl.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL alt_shift_tdl.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL alt_shift_tdl.cmp FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL alt_shift_tdl.bsf FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL alt_shift_tdl_inst.vhd FALSE
