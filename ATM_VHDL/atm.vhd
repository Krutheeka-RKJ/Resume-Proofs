library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity atm is
	port(A: in std_logic_vector(7 downto 0);
			Y: out std_logic_vector(10 downto 0));
end entity atm;

architecture struct of atm is

component div is
generic(
			N : integer:=8; -- operand width
			NN : integer:=16 -- result width
        );
port (
			Nu: in std_logic_vector(N-1 downto 0);-- Nu (read numerator) is dividend
			D: in std_logic_vector(N-1 downto 0);-- D (read Denominator) is divisor
			RQ: out std_logic_vector(NN-1 downto 0)--upper N bits of RQ will have remainder and lower N bits will have quotient
) ;
end component;

component zerocheck is
	port(A: in std_logic_vector(7 downto 0);
			B: out std_logic);
end component zerocheck;

component Mux_2bit is
	port(A,B,C,D: in std_logic_vector(1 downto 0);
		  SEL: in std_logic_vector(1 downto 0);
		  Y: out std_logic_vector(1 downto 0));
end component Mux_2bit;

signal S1,S2,S3,S4:std_logic_vector(7 downto 0);
signal p,q,r,sel1, sel0: std_logic;
signal zero: std_logic:= '0';
signal two: std_logic_vector(1 downto 0):= "10";
signal three: std_logic_vector(1 downto 0):= "11";
signal hundred: std_logic_vector(7 downto 0):= "01100100";
signal fifty: std_logic_vector(7 downto 0):= "00110010";
begin

   --distribution of notes
	div1: div port map(Nu => A, D => hundred, RQ(15 downto 8) => S1, RQ(7 downto 0) => S2);
	div2: div port map(Nu => S1, D => fifty, RQ(15 downto 8) => S3, RQ(7 downto 0) => S4);
	Y(8 downto 7) <= S2(1 downto 0);
	Y(6) <= S4(0);
	Y(5 downto 0) <= S3(5 downto 0);

	--priority order
	z1: zerocheck port map(A => A, B => r);
	o1: OR_2 port map(A => S2(1), B => S2(0), Y => p); --sel1 = A + B + C
	o2: OR_2 port map(A => p, B => S4(0), Y => sel1); --sel0 = A + B +C' 
	inv1: INVERTER port map(A => S4(0), Y => q);
	o3: OR_2 port map(A => p, B => q, Y => sel0);
	
	mux1: Mux_2bit port map(A => two, B(1) => zero, B(0) => r, C => two,  
								D => three, SEL(1) => sel1, SEL(0) => sel0, Y => Y(10 downto 9));

end struct;
