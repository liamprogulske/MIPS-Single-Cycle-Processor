LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;


ENTITY PC_register IS
   PORT( 
      PC_next : IN     std_logic_vector (31 DOWNTO 0);
      clk     : IN     std_logic;
      rst     : IN     std_logic;
      PC      : OUT    std_logic_vector (31 DOWNTO 0)
   );
END PC_register ;


ARCHITECTURE struct OF PC_register IS


BEGIN

    process1: process (clk,rst)
   
    BEGIN --Reset
        if (rst = '1') then --reset actions
            PC <= x"00400000"; --text segment start
        elsif (clk'EVENT AND clk = '1') then
            PC <= PC_next;
        end if;    
    END process process1;
END struct;
