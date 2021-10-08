library ieee;
use ieee.std_logic_1164.all;
entity DUT is
   port(input_vector: in std_logic_vector(7 downto 0);
       	output_vector: out std_logic_vector(10 downto 0)); 
end entity;

architecture DutWrap of DUT is
   component atm is
	port(A: in std_logic_vector(7 downto 0);
			Y: out std_logic_vector(10 downto 0));
   end component;
begin

   add_instance: atm --change here
			port map (                    
					
					A => input_vector(7 downto 0), --change here
					
                                        
					
					Y => output_vector(10 downto 0));

end DutWrap;

