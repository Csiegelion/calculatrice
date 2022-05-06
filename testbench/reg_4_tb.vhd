library IEEE ;
use IEEE.std_logic_1164.all ;

entity reg_4_simu is
end reg_4_simu ;

architecture archi_reg_4_simu of reg_4_simu is
signal clear, horloge : std_logic;
signal donnee, sortie : std_logic_vector(3 downto 0);

component reg_4
          port (CLK,Clear : In  std_logic;
			ent : In  std_logic_vector(3 downto 0); 
            Q      : Out std_logic_vector(3 downto 0 ));
end component ;

begin

porte_logique : reg_4
     port map (CLK=> horloge, Clear => clear, ent => donnee, Q => sortie) ;

sequence : process
  begin
    horloge <= '0' ; wait for 50 ns ;
     loop
      horloge <= not (horloge) ; wait for 50 ns ;
     end loop ;
end process ;

stimulis : process
  begin
    donnee <= "0010" ; wait for 30 ns ;
    clear  <= '0' ; wait for 30 ns ;
    clear  <= '1' ; wait for 130 ns ;
    donnee <= "1110" ; wait for 230 ns ;
    donnee <= "0001" ; wait for 330 ns ;
end process ;

end ;
