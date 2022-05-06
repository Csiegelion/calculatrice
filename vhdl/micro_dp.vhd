-------------------------------------------------------------------------------
-- Description de l'ALU comportementale avec 1 seul appel procedure Addition --
-------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.micro_pkg.all;

entity alu is
	port(opA,opB : in reg8;
		out_alu : out reg8;
		op_alu : in reg3); 	
end alu;
architecture alu of alu is

	signal input_adder1, input_adder2, output_adder : reg8;
	signal cin: std_logic;

	begin
------------------------ A COMPLETER ------------------------------------
-------------------------------------------------------------------------

	with op_alu select
		input_adder1 <=
			opA  when AplusB,
			opA  when AsubB,
			opA  when IncA,
			opA  when DecA,
		  "00000000" when others;

	with op_alu select
		input_adder2 <=
				opB  when AplusB,
			   not(opB)  When AsubB,
				opB  when PassB,
			  "11111111" when DecA,
			  "00000000" when others;

	with op_alu select 
		cin <= '0' when AplusB,
		       '1' when AsubB,
		       '1' when IncA,
		       '0' when DecA,
		       '0' when PassB,
		       '0' when others;
			

	add_AB(input_adder1, input_adder2, cin, output_adder);

 
 	with op_alu select
		out_alu <= output_adder when AplusB,
				output_adder when AsubB,
				output_adder when IncA,
				output_adder when DecA,
				output_adder when PassB,
			    opA and opB when AandB,
			    opA or opB  when AorB,
			       not(opA) when notA,
			     "00000000" when others;


	end alu;

--------------------------------------------------------------------------
--  Description structurelle du chemin de donnees (actif front descendant d'horloge)
--------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.micro_pkg.all;

entity datapath is
	port(	m_inst			: in micro_instructions;
		clk, rst		: in std_logic;
		instructions, address 	: out reg8;
		data_in			: in reg8;
		data_out		: out reg8;
		z         		: out std_logic	);
end datapath;

architecture datapath of datapath is

	component reg8_rst
		port( 	clk, rst, ce	: in std_logic;
			d		: in reg8;
			q		: out reg8	);
	end component;

        component bcregs
		port( 	clk, rst, wreg	: in std_logic;       
			irs		: in reg4; 
			inREG		: in reg8;
			source1, source2: out reg8 ); 
	end component;         
	
	component reg8_pc
		port( 	clk, rst, wPC, incPC	: in std_logic; 
			inPC			: in reg8; 
			outPC			: out reg8 );
	end component;
	
	component reg8_sp
		port( 	clk, rst, wSP, incSP, orgSP, sel_SP_out	: in std_logic; 
			inSP					: in reg8; 
			outSP					: out reg8 );
	end component;
	
	component alu
	port(opA,opB : in reg8;
			out_alu : out reg8;
			op_alu : in reg3 );
	end component;
	
	signal out_alu, opA, s2, reg_in, ir, pc, sp, opB: reg8;
	signal regadr: reg4; -- 4 bits de poids faible de ir
	begin 
 
	regadr<=ir(3 downto 0);
	
	instructions<=ir;
	
	with m_inst.sel_din select
		reg_in  <= data_in when '1',
			  out_alu when others;
	with m_inst.selb select
		opB <= s2 when '1',
			  pc when others;
	with m_inst.sel_adr select
		address  <= sp when '1',
			  out_alu when others;

	with m_inst.sel_out_pc select
		data_out  <= pc when '1',
			  "ZZZZZZZZ" when others;
	with m_inst.sel_out_reg select
		data_out  <= opA when '1',
			  "ZZZZZZZZ" when others;
	
	process(rst, clk)

	begin

	if (rst = '1') then z <= '0';
		elsif (CLK'event and CLK = '0') then
			if (m_inst.nz = '1' and out_alu ="00000000") then z<='1'; 
			else z<='0';
			end if;
	end if;
 	end process;
------------------------ A COMPLETER ------------------------------------
-------------------------------------------------------------------------
RIR : reg8_rst	 		port map(clk => clk, rst => rst, ce => m_inst.wenable, d => reg_in, q => ir );

mapping_bcregs : bcregs 	port map(clk => clk, rst => rst, irs => regadr, inREG => reg_in, source1 => opA, source2 => s2, wreg => m_inst.wreg);

mapping_alu : alu 		port map( opA => opA, opB => opB, out_alu => out_alu, op_alu => m_inst.op_alu );

mapping_pc : reg8_pc		port map(clk => clk, rst => rst,  wPC => m_inst.wpc, incPC => m_inst.incpc, inPC => reg_in, outPC => pc);

mapping_sp : reg8_sp 		port map(clk => clk, rst => rst, wSP => m_inst.wSP, incSP => m_inst.incSP, orgSP => m_inst.orgSP, sel_SP_out => m_inst.sel_SP_out, inSP => out_alu, outSP => sp); 

	
end datapath;
