LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY sign_extend IS
   PORT( 
      Instruction_15_0               : IN     std_logic_vector (15 DOWNTO 0);
      Instruction_15_0_Sign_Extended : OUT    std_logic_vector (31 DOWNTO 0)
   );
END sign_extend ;


ARCHITECTURE struct OF sign_extend IS

BEGIN

   Instruction_15_0_Sign_Extended(15 downto 0) <= Instruction_15_0;
   Instruction_15_0_Sign_Extended(31 downto 16) <= (others => Instruction_15_0(15));

END struct;
