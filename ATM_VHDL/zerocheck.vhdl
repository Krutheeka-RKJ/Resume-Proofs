library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity zerocheck is
	port(A: in std_logic_vector(7 downto 0);
			B: out std_logic);
end entity zerocheck;

architecture struct of zerocheck is
signal sig: std_logic_vector(5 downto 0);
begin
		o1: OR_2 port map(A => A(7), B => A(6), Y => sig(0));
		o2: OR_2 port map(A => sig(0), B => A(5), Y => sig(1));
		o3: OR_2 port map(A => sig(1), B => A(4), Y => sig(2));
		o4: OR_2 port map(A => sig(2), B => A(3), Y => sig(3));
		o5: OR_2 port map(A => sig(3), B => A(2), Y => sig(4));
		o6: OR_2 port map(A => sig(4), B => A(1), Y => sig(5));
		o7: OR_2 port map(A => sig(5), B => A(0), Y => B);
end struct;		