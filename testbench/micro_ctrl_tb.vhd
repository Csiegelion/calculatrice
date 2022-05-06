library IEEE ;
use IEEE.std_logic_1164.all ;
use work.micro_pkg.all;

entity micro_ctrl_simu is 
end micro_ctrl_simu;

architecture micro_ctrl_simu of micro_ctrl_simu is
signal m_inst : micro_instructions;
signal ce, rw, rst, clk, z, e_halt : std_logic;
signal ir : reg8;


	component controle
		port	(m_inst	: out micro_instructions;
	      	  	ce,rw   : out std_logic;
			rst,clk	: in std_logic;
			z	: in std_logic;
			ir	: in reg8;
			e_halt	: out std_logic );

	end component;

begin

micro_control : controle
	port map( m_inst=>m_inst, ce=>ce, rw=>rw, rst=>rst, clk=>clk, z=>z, ir=>ir, e_halt=>e_halt); 

sequence : process
  begin
    clk <= '0' ; wait for 50 ns ;
     loop
      clk <= not (clk) ; wait for 50 ns ;
     end loop ;
end process ;

stimulis : process

begin
	rst<='1'; wait for 150 ns;
	rst<='0'; wait for 150 ns;

	ir <= "00000000"; wait for 50 ns;
ir <= "00010000"; wait for 50 ns;
ir <= "00100000"; wait for 50 ns;
ir <= "00110000"; wait for 50 ns;
ir <= "01000000"; wait for 50 ns;
ir <= "01010000"; wait for 50 ns;
ir <= "01100000"; wait for 50 ns;
ir <= "01110000"; wait for 50 ns;
ir <= "10000000"; wait for 50 ns;
ir <= "10010000"; wait for 50 ns;
ir <= "10100000"; wait for 50 ns;
ir <= "10110000"; wait for 50 ns;
ir <= "11000000"; wait for 50 ns;
ir <= "11010000"; wait for 50 ns;
ir <= "11100000"; wait for 50 ns;
ir <= "11110000"; wait for 50 ns;

















end process;	

end;
