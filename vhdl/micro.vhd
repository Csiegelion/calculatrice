-------------------------------------------------------------------------
--	Processeur 8 bits, version 1.0
--	Nom de l'etudiant :
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- package micro_pkg declare les types et soustypes de base
-------------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;

package micro_pkg is
	subtype reg8   is std_logic_vector(7 downto 0);
	subtype reg4   is std_logic_vector(3 downto 0);
	subtype reg3   is std_logic_vector(2 downto 0);
	subtype reg2   is std_logic_vector(1 downto 0);

	type micro_instructions is record
		wenable:	std_logic; -- autorisation d'ecriture dans le registre d'instruction
		wreg:     	std_logic; -- autorisation d'ecriture dans les registres de donnes
		incSP		:std_logic;
		orgSP		:std_logic;
		sel_SP_out	:std_logic;
		sel_din		:std_logic;
		sel_out_reg	:std_logic;
		op_alu		:std_logic_vector(2 downto 0);
		nz		:std_logic;
		sel_out_pc	:std_logic;
		incpc		:std_logic;
		wpc		:std_logic;
		sel_adr		:std_logic;
		selb		:std_logic;
		wSP		:std_logic;

		
		------------------------ A COMPLETER ------------------------------------
                -------------------------------------------------------------------------
		---.... 17 signaux
	end record;

	constant d0  : reg2 := "00";       -- declaration des registres de donnees
	constant d1  : reg2 := "01";
	constant d2  : reg2 := "10";
	constant d3  : reg2 := "11";

	constant AplusB	: reg3 := "000";   -- declaration des operations de l'ALU
	constant AsubB	: reg3 := "001";
	constant IncA	: reg3 := "010";
	constant DecA	: reg3 := "011";
	constant PassB	: reg3 := "100";	
	constant AandB	: reg3 := "101";
	constant AorB	: reg3 := "110";
	constant notA	: reg3 := "111";	


	procedure add_AB (	signal A, B	: in  reg8;
				signal Cin	: in std_logic;
				signal S	: out reg8	);

	component reg8_rst
		port( 	clk, rst, ce	: in std_logic;
			d		: in reg8;
			q		: out reg8	);
	end component;

end micro_pkg;

package body micro_pkg is	
	-- Somme sur 8 bits (full adder 1 bit a etendre sur 8 bits)
	procedure add_AB (	signal A, B	: in  reg8;  
				signal Cin	: in std_logic;
				signal S	: out reg8	) is
				
		variable carry : std_logic;
		begin       

		carry:=Cin;			

		for i in 0 to 7 loop 
			
			S(i) <= (A(i) xor B(i)) xor carry; 
			carry:= (A(i) and B(i)) or(A(i) and carry) or (B(i) and carry);

		end loop;



	end add_AB;

	
end micro_pkg;
-------------------------------------------------------------------------

--------------------------------------------------------------------------
-- Realisation du processeur (datapath + controle)
--------------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use work.micro_pkg.all;

entity processeur is
	port(  	clk,rst		: in std_logic;
		data_in		: in reg8;
		data_out	: out reg8;
		address		: out reg8;
		ce,rw		: out std_logic;
		e_halt		: out std_logic );
end processeur;   

architecture processeur of processeur is
begin	
------------------------ A COMPLETER ------------------------------------
-------------------------------------------------------------------------       
	
end processeur;
