library IEEE ;
use IEEE.std_logic_1164.all ;
use work.micro_pkg.all;

entity add_AB_simu is 
end add_AB_simu;

architecture archi_add_AB_simu of add_AB_simu is
signal A, B : reg8;
signal C : std_logic;
signal  sortie : reg8;

--component add_AB
--         port( 	c	:in std_logic;
--		a, b		:in reg8;
--		s		:out reg8 );
--end component ;
--begin
--porte_logique : add_AB
--    port map ( a=>A , b => B, s => sortie, c => C) ;


--stimulis : process
--  begin
--	C<='0'; A<="00000001"; B<="00000001"; wait for 50 ns;
 	
	
   
--end process ;

--end ;
begin
	
add_AB( A, B, C, sortie);
	
stimulis : process

	begin
	


	C<='0'; A<="00000001"; B<="00000001"; wait for 50 ns;		
	C<='1'; A<="00000001"; B<="00000001"; wait for 50 ns;



	end process;

end;

------------------------------------------------------------

library IEEE ;
use IEEE.std_logic_1164.all ;
use work.micro_pkg.all;

entity alu_simu is 
end alu_simu;

architecture archi_alu_simu of alu_simu is
signal A, B, outalu : reg8;
signal opalu : reg3;




component alu
         port( 	opA,opB : in reg8;
		out_alu : out reg8;
		op_alu : in reg3 );
end component ;



begin

	
mapping : alu

	port map( opA => A, opB => B, out_alu => outalu, op_alu => opalu );

stimulis : process
  begin
	A<= "00001111"; B<="00000011"; wait for 50 ns;
	opalu<="000"; wait for 50 ns;
	opalu<="001"; wait for 50 ns;
	opalu<="010"; wait for 50 ns;
	opalu<="011"; wait for 50 ns;	
	opalu<="100"; wait for 50 ns;
	opalu<="101"; wait for 50 ns;
	opalu<="110"; wait for 50 ns;
	opalu<="111"; wait for 50 ns;
		
   
end process ;

end;

------------------------------------------------------------------------------------
library IEEE ;
use IEEE.std_logic_1164.all ;
use work.micro_pkg.all;

entity datapath_simu is 
end datapath_simu;

architecture archi_datapath_simu of datapath_simu is
signal  rst, horloge,  z  : std_logic;
signal m_inst : micro_instructions;
signal data_in, data_out, address, ir : reg8;


component datapath 
	port(	m_inst			: in micro_instructions;
		clk, rst		: in std_logic;
		instructions, address 	: out reg8;
		data_in			: in reg8;
		data_out		: out reg8;
		z         		: out std_logic	);
end component;

begin

sequence : process
  begin
    horloge <= '0' ; wait for 50 ns ;
     loop
      horloge <= not (horloge) ; wait for 50 ns ;
     end loop ;
end process ;


u : datapath 
	port map( clk => horloge, rst => rst,m_inst => m_inst, data_in => data_in, data_out =>data_out, z => z, address => address, instructions => ir);

stimulis : process
  begin


	
m_inst<=('0','0','0','0','0','1','0',"000",'0','0','0','0','0','0','0');			
rst<='1';			
data_in<="00001111";






end process;
end;	   



















