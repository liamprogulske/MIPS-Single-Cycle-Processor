LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;

ENTITY ALU IS
   PORT( 
      A           : IN     std_logic_vector (31 DOWNTO 0);
      ALU_control : IN     std_logic_vector (3 DOWNTO 0);
      B           : IN     std_logic_vector (31 DOWNTO 0);
      ALU_result  : OUT    std_logic_vector (31 DOWNTO 0);
      zero        : OUT    std_logic;
      overflow    : OUT    std_logic
   );
END ALU ;


ARCHITECTURE behav OF ALU IS

   -- Architecture declarations
   CONSTANT zero_value : std_logic_vector(31 downto 0) := (others => '0');

   -- Internal signal declarations
   SIGNAL ALU_result_internal : std_logic_vector(31 DOWNTO 0);
   SIGNAL s_A, s_B, s_C : std_logic;

BEGIN
   ALU_result <= ALU_result_internal;
   zero <= '1' when (ALU_result_internal = zero_value) else '0';

   s_A <= A(31);
   s_B <= B(31);
   s_C <= ALU_result_internal(31);
     
   ---------------------------------------------------------------------------
   process1 : PROCESS (A, B, ALU_control, s_A, s_B, s_C)
   ---------------------------------------------------------------------------
   BEGIN
      ALU_result_internal <= zero_value;
      overflow <= '0';
      CASE ALU_control IS
	      WHEN "0000" =>
		      ALU_result_internal <= A and B;
	      WHEN "0001" =>
		      ALU_result_internal <= A or B;
	      WHEN "0010" =>
		      ALU_result_internal <= A + B;
		      overflow <= ((NOT s_A) AND (NOT s_B) AND (    s_C)) OR
                          ((    s_A) AND (    s_B) AND (NOT s_C)); 
	      WHEN "0110" =>
		      ALU_result_internal <= A - B;
		      overflow <= ((NOT s_A) AND (    s_B) AND (    s_C)) OR
                          ((    s_A) AND (NOT s_B) AND (NOT s_C)); 
	      WHEN "0111" =>
             IF A < B THEN
                ALU_result_internal <= "00000000000000000000000000000001";
             ELSE
                ALU_result_internal <= zero_value;
             END IF;
	      WHEN "1100" =>
		      ALU_result_internal <= A nor B;
	      WHEN others =>
		      ALU_result_internal <= zero_value;
		      overflow <= '0';
      END CASE;
   END PROCESS process1;
END behav;
