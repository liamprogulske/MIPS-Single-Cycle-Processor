LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;

ENTITY adder_second IS
   PORT( 
      A          : IN     std_logic_vector (31 DOWNTO 0);
      B          : IN     std_logic_vector (31 DOWNTO 0);
      add_result : OUT    std_logic_vector (31 DOWNTO 0)
   );
END adder_second ;


ARCHITECTURE struct OF adder_second IS

BEGIN

    add_result <= A + B;

END struct;
