--------------------------------------------------------------------------
--  Description comportementale du bloc de controle (actif front montant d'horloge)
--------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;
use work.micro_pkg.all;
entity controle is
	port (	m_inst	: out micro_instructions;
	        ce,rw   : out std_logic;
			rst,clk	: in std_logic;
			z	: in std_logic;
			ir	: in reg8;
			e_halt	: out std_logic );
end controle;

architecture controle of controle is 

        type STATE is (INIT,FETCH,EXEC);
        signal op                	: reg4;  -- 4 bits de poids fort de ir
		signal etat					: STATE; -- permet de differencier INIT, FETCH et EXEC
	signal halt : std_logic;

	begin

	e_halt<=halt;	
	op <= ir(7 downto 4);

	machine_etat : process(CLK,rst)
	begin 
	if(rst='1') then etat<=INIT; 
		elsif (CLK'event and CLK = '1') then
		case etat is
			when INIT => etat <= FETCH;
			when FETCH => etat <= EXEC;
			when EXEC =>
				case halt is
				when '1' => etat <= EXEC;
				when others => etat <= FETCH;
				end case;
			end case;
		end if;
	end process machine_etat;
	

	sortie : process(etat)

	begin
	

	halt<='0';
	case etat is

	when INIT =>
	
		m_inst<=('0','0','0','0','0','0','0',"000",'0','0','0','0','0','0','0');
		ce<='0';
		rw<='0';

	when FETCH =>

		m_inst<=('1','0','0','0','0','0','0',"100",'0','0','1','1','0','0','0');
		ce<='1';
		rw<='1';
		
	when EXEC =>

		case op is 

			when "0000" => m_inst<=('1','1','0','0','0','0','0',"101",'1','0','0','0','0','1','0'); ce<='0'; rw<='1';
			when "0001" => m_inst<=('1','1','0','0','0','0','0',"110",'1','0','0','0','0','1','0'); ce<='0'; rw<='1';
			when "0010" => m_inst<=('1','1','0','0','0','0','0',"000",'1','0','0','0','0','1','0'); ce<='0'; rw<='1';
			when "0011" => m_inst<=('1','1','0','0','0','0','0',"001",'1','0','0','0','0','1','0'); ce<='0'; rw<='1';
			when "0100" => m_inst<=('1','1','0','0','0','0','0',"100",'1','0','0','0','0','1','0'); ce<='0'; rw<='1';
			when "0101" => m_inst<=('0','0','0','0','0','0','0',"100",'0','0','0','0','0','0','0'); ce<='0'; rw<='0';
			when "0110" => m_inst<=('1','1','0','0','0','1','0',"100",'0','0','0','0','0','1','0'); ce<='1'; rw<='1';
			when "0111" => m_inst<=('1','1','0','0','0','0','1',"100",'0','0','0','0','0','1','0'); ce<='1'; rw<='0';
			when "1000" => m_inst<=('1','1','0','0','0','0','0',"011",'1','0','0','0','0','1','0'); ce<='0'; rw<='1';
			when "1001" => m_inst<=('1','1','0','0','0','0','0',"010",'1','0','0','0','0','1','0'); ce<='0'; rw<='1';
			when "1010" => m_inst<=('1','1','0','0','0','0','0',"111",'0','0','0','0','0','1','0'); ce<='0'; rw<='1';

			when "1011" => ce<='0'; rw<='1'; halt<='1';

			when "1100" => m_inst<=('1','1','0','0','0','0','0',"100",'0','0','0','1','0','1','0'); ce<='0'; rw<='1';

			
			when "1101" =>
				if( z='1') then  m_inst<=('1','1','0','0','0','0','0',"100",'0','0','0','1','0','1','0'); ce<='0'; rw<='1';				
				else m_inst<=('0','0','0','0','0','0','0',"000",'0','0','0','0','0','0','0'); ce<='0'; rw<='1';
				end if;


			when "1110" => m_inst<=('1','1','1','1','1','0','0',"100",'0','1','0','1','0','1','1'); ce<='1'; rw<='0';
			when "1111" => m_inst<=('1','1','0','1','1','1','0',"100",'0','1','0','1','0','1','1'); ce<='1'; rw<='1';
			when others => m_inst<=('0','0','0','0','0','0','0',"000",'0','0','0','0','0','0','0'); ce<='0'; rw<='0';
end case;
end case;

	end process;







				 		 



end controle;
