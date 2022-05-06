library IEEE ;
use IEEE.std_logic_1164.all ;
use work.micro_pkg.all;

entity reg8_rst_simu is
end reg8_rst_simu ;

architecture archi_reg8_rst_simu of reg8_rst_simu is
signal clear, horloge, ce : std_logic;
signal donnee, sortie : reg8;

component reg8_rst
         port( 	clk, rst, ce	:in std_logic;
		d		:in reg8;
		q		:out reg8 );
end component ;

begin

porte_logique : reg8_rst
     port map (clk=> horloge, rst => clear, d => donnee, q => sortie, ce => ce) ;

sequence : process
  begin
    horloge <= '0' ; wait for 50 ns ;
     loop
      horloge <= not (horloge) ; wait for 50 ns ;
     end loop ;
end process ;

stimulis : process
  begin

	

	
end process ;

end ;

---------------------------------------------------------------------

library IEEE ;
use IEEE.std_logic_1164.all ;
use work.micro_pkg.all;

entity reg8_r0_simu is
end reg8_r0_simu ;

architecture archi_reg8_r0_simu of reg8_r0_simu is
signal clear, horloge, ce : std_logic;
signal donnee, sortie : reg8;

component reg8_r0
         port( 	clk, rst, ce	:in std_logic;
		inptr		:in reg8;
		outptr		:out reg8 );
end component ;

begin

porte_logique : reg8_r0
     port map (clk=> horloge, rst => clear, inptr => donnee, outptr => sortie, ce => ce) ;

sequence : process
  begin
    horloge <= '0' ; wait for 50 ns ;
     loop
      horloge <= not (horloge) ; wait for 50 ns ;
     end loop ;
end process ;

stimulis : process
  begin




	

  
end process ;

end ;

---------------------------------------------------------------------
library IEEE ;
use IEEE.std_logic_1164.all ;
use work.micro_pkg.all;

entity reg8_ptr_simu is
end reg8_ptr_simu ;

architecture archi_reg8_ptr_simu of reg8_ptr_simu is
signal clear, horloge, ce : std_logic;
signal donnee, sortie : reg8;

component reg8_ptr
         port( 	clk, rst, ce	:in std_logic;
		inptr		:in reg8;
		outptr		:out reg8 );
end component ;

begin

porte_logique : reg8_ptr
     port map (clk=> horloge, rst => clear, inptr => donnee, outptr => sortie, ce => ce) ;

sequence : process
  begin
    horloge <= '0' ; wait for 50 ns ;
     loop
      horloge <= not (horloge) ; wait for 50 ns ;
     end loop ;
end process ;

stimulis : process
  begin

end process ;

end ;

-----------------------------------------------------------------------

library IEEE ;
use IEEE.std_logic_1164.all ;
use work.micro_pkg.all;

entity reg8_pc_simu is
end reg8_pc_simu ;

architecture archi_reg8_pc_simu of reg8_pc_simu is
signal clear, horloge, ce, mu : std_logic;
signal donnee, sortie : reg8;

component reg8_pc
         port( 	clk, rst, wPC, incPC	:in std_logic;
		inPC		:in reg8;
		outPC		:out reg8 );
end component ;

begin
mapping : reg8_pc
     port map (clk=> horloge, rst => clear, inPC => donnee, outPC => sortie, wPC => ce, incPC=>mu) ;


sequence : process
  begin
    horloge <= '0' ; wait for 50 ns ;
     loop
      horloge <= not (horloge) ; wait for 50 ns ;
     end loop ;
end process ;

stimulis : process
  begin
	ce<='1';
	mu<='0';
	clear<='1'; wait for 100 ns;
	
	clear<='0'; donnee<="00000001"; wait for 200 ns;
	mu<='0'; donnee<="00000010"; wait for 100 ns;
	mu<='1';wait for 150 ns;
	clear<='0'; wait for 200 ns;
	
   
end process ;

end ;
-------------------------------------------------------------------
library IEEE ;
use IEEE.std_logic_1164.all ;
use work.micro_pkg.all;

entity reg8_sp_simu is
end reg8_sp_simu ;

architecture archi_reg8_sp_simu of reg8_sp_simu is
signal clear, horloge, ce, muSP, muORG, muSEL : std_logic;
signal donnee, sortie : reg8;

component reg8_sp
         port( 	clk, rst, wSP, incSP, orgSP, sel_SP_out	:in std_logic;
		inSP		:in reg8;
		outSP		:out reg8 );
end component ;

begin
mapping : reg8_sp
     port map (clk=> horloge, rst => clear, inSP => donnee, outSP => sortie, wSP => ce, incSP=>muSP, orgSP=>muORG, sel_SP_out=>muSEL) ;


sequence : process
  begin
    horloge <= '0' ; wait for 50 ns ;
     loop
      horloge <= not (horloge) ; wait for 50 ns ;
     end loop ;
end process ;

stimulis : process
  begin
	ce<='1';
	muSP<='1';
	muORG<='0';
	muSEL<='1';
	clear<='1'; wait for 100 ns;
	
	clear<='0'; donnee<="00000001"; wait for 200 ns;
	muSP<='0'; donnee<="00000010"; wait for 100 ns;
	muSP<='1';wait for 150 ns;
	clear<='0'; wait for 200 ns;
	
   
end process ;

end ;

