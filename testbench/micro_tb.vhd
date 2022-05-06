--*************************************************************
--* This file is automatically generated test bench template  *
--* By ACTIVE-VHDL    <TBgen v1.10>. Copyright (C) ALDEC Inc. *
--*                                                           *
--* This file was generated on:               11:42, 31/08/00 *
--* Tested entity name:                            processeur *
--* File name contains tested entity:       $DSN\src\mp8b.vhd *
--*************************************************************

library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use work.micro_pkg.all;

	-- Add your library and packages declaration here ...

entity processeur_tb is
end processeur_tb;

architecture TB_ARCHITECTURE of processeur_tb is
	-- Component declaration of the tested unit
	component processeur
	port(
		clk : in std_logic;
		rst : in std_logic;
		data_in : in std_logic_vector(7 downto 0);
		data_out : out std_logic_vector(7 downto 0);
		address : out std_logic_vector(7 downto 0);
		ce : out std_logic;
		rw : out std_logic;
		e_halt : out std_logic );
end component;


	type mem1 is array (0 to 255) of std_logic_vector(7 downto 0);
	constant TAMaddress : integer := 256;
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : std_logic;
	signal rst : std_logic;
	signal data_in : std_logic_vector(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal data_out,ins: std_logic_vector(7 downto 0);
	signal ad : std_logic_vector(7 downto 0);
	signal start : std_logic;
	signal ce : std_logic;
	signal rw : std_logic;
	signal e_halt : std_logic;
	signal memad : integer;
	signal RAM : mem1;
	
	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : processeur
		port map
			(clk => clk,
			rst => rst,
			data_in => data_in,
			data_out => data_out,
			address => ad,
			ce => ce,
			rw => rw,
			e_halt => e_halt );

	-- Add your stimulus here ...
	--
	-- gestion du reset
	--	  
	process
	    begin
	rst <='1'; wait for 15 ns;
	rst <= '0'; wait for 1000 ms;
	end process;  
	--
	-- gestion de la clock
	--	  
	process
	    begin
	     clk <= '1'; wait for 10 ns;
	     clk <= not(clk); wait for 10 ns;
    end process;
	
	-- memoire
    data_in <= RAM(CONV_INTEGER(ad)) when CONV_INTEGER(ad)<(TAMaddress + 1) and ce='1' and rw='1' else (others=>'Z');
	
	-- ecriture synchrone dans la memoire (tableau RAM)
	process(start,clk, ce, rw)
	begin
		if (start'event and start='1') then
			  RAM(memad) <= ins;
		elsif clk'event and clk='0' and ce='1' and rw='0' then	
		  if CONV_INTEGER(ad)>=0 and CONV_INTEGER(ad)<=TAMaddress then
			  RAM(CONV_INTEGER(ad)) <=data_out;	
		  end if;
		end if;
	end process;

	-- realise le chargement des instructions dans la memoire(tableau RAM) pour reset actif
	process
	begin
		wait until rst = '1';
		
		wait for 2 ps; memad <= 0; ins <= x"61"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 1; ins <= x"90"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 2; ins <= x"62"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 3; ins <=x"90"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 4; ins <=x"63"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 5; ins <=x"07"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 6; ins <=x"1B"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 7; ins <=x"26"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 8; ins <=x"90"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 9; ins <=x"61"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 10; ins <=x"3E"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 11; ins <=x"D4"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 12; ins <=x"90"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 16; ins <=x"41"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 17; ins <=x"91"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 18; ins <=x"64"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 19; ins <=x"E0"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 20; ins <=x"50"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 21; ins <=x"50"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 22; ins <=x"77"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 23; ins <=x"44"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 24; ins <=x"61"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 25; ins <=x"A1"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 26; ins <=x"B0"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 208; ins <=x"91"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 209; ins <=x"64"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 210; ins <=x"62"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 211; ins <=x"F0"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 224; ins <=x"11"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 225; ins <=x"22"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 226; ins <=x"33"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 227; ins <=x"10"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 228; ins <=x"D0"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 229; ins <=x"FA"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 230; ins <=x"00"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 231; ins <=x"00"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 232; ins <=x"00"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
		wait for 2 ps; memad <= 233; ins <=x"00"; wait for 1 ps; start <= '1'; wait for 1 ps; start <= '0';
			
	end process;
	
end TB_ARCHITECTURE;
