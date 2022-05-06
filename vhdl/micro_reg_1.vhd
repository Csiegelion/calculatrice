-------------------------------------------------------------------------
-- Registre general (actif front descendant d'horloge) avec reset asynchrone actif niveau haut utiliser pour
-- R1,R2,R3 du banc de registre et le registre PC => initialiser a x"00"
-------------------------------------------------------------------------
--library IEEE;
--use IEEE.Std_Logic_1164.all;
--use work.micro_pkg.all;

--entity reg8_rst is
--	port( 	clk, rst, ce	:in std_logic;
--		d		:in reg8;
--		q		:out reg8 );
--end reg8_rst;

--architecture reg8_rst of reg8_rst is
--	begin
--	process (clk, rst)
--		begin
	
	
--		if (rst = '1') then q <= "00000000";
--		elsif (CLK'event and CLK = '0') then 
--			if ( ce = '1' ) then q <= d;
--		end if;
--	end if;


--	end process;
--end reg8_rst;

-------------------------------------------------------------------------
--- Registre (actif front descendant d'horloge) avec reset asynchrone actif niveau haut utiliser pour
-- R0 => initialiser a x"E0"
-------------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use work.micro_pkg.all;

entity reg8_r0 is
	port( 	clk, rst, ce	:in std_logic;
		inptr		:in reg8;
		outptr		:out reg8 );
end reg8_r0;

architecture reg8_r0 of reg8_r0 is
	begin
	process (clk, rst)
		begin
	
	
	
		if (rst = '1') then outptr <= "11100000";
		elsif (CLK'event and CLK = '0') then 
			if ( ce = '1' ) then outptr <= inptr;
		end if;
	end if;

	end process;
end reg8_r0;

-------------------------------------------------------------------------
--- Registre (actif front descendant d'horloge) avec reset asynchrone actif niveau haut utiliser pour
-- la stack => initialiser a x"FA"
-------------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use work.micro_pkg.all;

entity reg8_ptr is
	port( 	clk, rst, ce	:in std_logic;
		inptr		:in reg8;
		outptr		:out reg8 );
end reg8_ptr;

architecture reg8_ptr of reg8_ptr is
	begin
	process (clk, rst)
		begin


	
		if (rst = '1') then outptr <= "11111010";
		elsif (CLK'event and CLK = '0') then 
			if ( ce = '1' ) then outptr <= inptr;
		end if;
	end if;


	end process;
end reg8_ptr;

-------------------------------------------------------------------------
-- Registre PC
-------------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.micro_pkg.all;

entity reg8_pc is
	port( 	clk, rst, wPC, incPC	: in std_logic;
		inPC			: in reg8;
		outPC			: out reg8 );
end reg8_pc;

architecture reg8_pc of reg8_pc is
	signal s1,sq : reg8;
	
component reg8_rst
         port( 	clk, rst, ce	:in std_logic;
		d		:in reg8;
		q		:out reg8 );
end component ;


	begin
mapping : reg8_rst
     port map (clk=> clk, rst => rst, d => s1, q => sq, ce => wPC) ;

	s1 <= inPC when incPC='0' else sq + 1;
	outPC <= sq;


end reg8_pc;

-------------------------------------------------------------------------
-- Registre SP
-------------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.micro_pkg.all;

entity reg8_sp is
	port( 	clk, rst, wSP, incSP, orgSP, sel_SP_out	: in std_logic;
		inSP					: in reg8;
		outSP					: out reg8 );
end reg8_sp;

architecture reg8_sp of reg8_sp is
	signal ssp, s1, s2: reg8;    		 -- signaux internes increment/decrement


component reg8_ptr
	port( 	clk, rst, ce	:in std_logic;
		inptr		:in reg8;
		outptr		:out reg8 );
end component ;


	begin

mapping : reg8_ptr
     port map (clk=> clk, rst => rst, inptr => s2, outptr => ssp, ce => wSP) ;
	
	s2 <= inSP when orgSP='0' else s1;
	s1 <= ssp-1 when incSP='0' else ssp+1;
	outSP <= ssp when sel_SP_out='0' else s1;




end reg8_sp;

--------------------------------------------------------------------------
-- Banc de registre R0..R3
--------------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use work.micro_pkg.all;
entity bcregs is
	port(	clk, rst, wreg		: in std_logic;
		irs			: in reg4;
		inREG			: in reg8;
		source1, source2	: out reg8 );
end bcregs;

architecture bcregs of bcregs is
	signal reg0, reg1, reg2, reg3: reg8;
	signal wen: std_logic_vector(3 downto 0);

component reg8_rst1
	port ( clk, ce, rst : in std_logic;
		d : in reg8;
		q : out reg8);
end component;

component reg8_r0
	port ( clk, ce, rst : in std_logic;
		inptr : in reg8;
		outptr : out reg8);
end component;


	begin

R0 : reg8_r0
	port map( clk => clk, rst => rst, ce => wen(0), inptr => inREG, outptr => reg0);
R1 : reg8_rst1
	port map( clk => clk, rst => rst, ce => wen(1), d => inREG, q => reg1);
R2 : reg8_rst1
	port map( clk => clk, rst => rst, ce => wen(2), d => inREG, q => reg2);
R3 : reg8_rst1
	port map( clk => clk, rst => rst, ce => wen(3), d => inREG, q => reg3);

with irs ( 1 downto 0 ) select
	source1 <= reg0 when "00",
		   reg1 when "01",
	     	   reg2 when "10",
		   reg3 when others;

with irs ( 3 downto 2 ) select
	source2 <= reg0 when "00",
		   reg1 when "01",
	     	   reg2 when "10",
		   reg3 when others;


wen(0)<=wreg when irs(1 downto 0)="00" else'0';

wen(1)<=wreg when irs(1 downto 0)="01" else'0';

wen(2)<=wreg when irs(1 downto 0)="10" else'0';
wen(3)<=wreg when irs(1 downto 0)="11" else'0';

end bcregs;


-----------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use work.micro_pkg.all;
 
entity reg8_rst is
    port(     clk, rst, ce    :in std_logic;
        d        :in reg8;
        q        :out reg8 );
end reg8_rst;
 
architecture reg8_rst of reg8_rst is
    begin
    process (clk, rst)
        begin
    if (rst = '1') then q <= "00000000";
    elsif (CLK'event and CLK = '0') then
    if ce='1' then q <= d;
    end if;
end if;
    end process;
end reg8_rst; 
