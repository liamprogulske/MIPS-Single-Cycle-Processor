LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY ALU_controller IS
   PORT( 
      ALU_op      : IN     std_logic_vector (1 DOWNTO 0);
      funct       : IN     std_logic_vector (5 DOWNTO 0);
      ALU_control : OUT    std_logic_vector (3 DOWNTO 0)
   );
END ALU_controller ;


ARCHITECTURE struct OF ALU_controller IS

BEGIN
    process1 : process (ALU_op, funct)
    begin
        case ALU_op is
        when "00" =>
            ALU_control <= "0010"; --lw, sw, add
        when "01" =>
            ALU_control <= "0110"; --beq, sub
        when "10" =>
            case funct is
            when "100000" =>
                ALU_control <= "0010"; --add
            when "100010" =>
                ALU_control <= "0110"; --sub
            when "100100" =>
                ALU_control <= "0000"; --AND
            when "100101" =>
                ALU_control <= "0001"; --OR
            when "101010" =>
                ALU_control <= "0111"; --set on less than
            when others =>
                ALU_control <= "1111"; --default
            end case;
        when others =>
            ALU_control <= "1111"; --default
        end case;
    end process process1;
END struct;
