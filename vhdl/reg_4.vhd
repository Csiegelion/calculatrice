library ieee;
use ieee.std_logic_1164.all;


entity reg_4 is
      port (ent       : In  std_logic_vector(3 downto 0);
	    CLK,Clear : In  std_logic;
            Q         : Out std_logic_vector (3 downto 0) );
end reg_4;

architecture archi_reg_4 of reg_4 is
begin
process(Clear,CLK)
begin

	if (Clear = '0') then Q <= "0000";
	elsif (CLK'event and CLK = '1') then Q <= ent;
	end if;

end process;
end;
