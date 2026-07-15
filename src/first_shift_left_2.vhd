LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY First_Shift_Left_2 IS
   PORT( 
      Instruction_25_0              : IN     std_logic_vector (25 DOWNTO 0);
      Instruction_25_0_Left_Shifted : OUT    std_logic_vector (27 DOWNTO 0)
   );
END First_Shift_Left_2 ;


ARCHITECTURE struct OF First_Shift_Left_2 IS

BEGIN

    Instruction_25_0_Left_Shifted <= (Instruction_25_0 & "00");

END struct;
