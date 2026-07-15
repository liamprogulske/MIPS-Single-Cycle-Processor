LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY Main_Control_Unit IS
   PORT( 
      Instruction_31_26 : IN     std_logic_vector (5 DOWNTO 0);
      Instruction_5_0   : IN     std_logic_vector (5 DOWNTO 0);
      ALUOp             : OUT    std_logic_vector (1 DOWNTO 0);
      ALUSrc            : OUT    std_logic;
      Beq               : OUT    std_logic;
      Bne               : OUT    std_logic;
      J                 : OUT    std_logic;
      Jal               : OUT    std_logic;      
      Jr                : OUT    std_logic;
      MemRead           : OUT    std_logic;
      MemToReg          : OUT    std_logic;
      MemWrite          : OUT    std_logic;
      RegDst            : OUT    std_logic;
      RegWrite          : OUT    std_logic
   );
END Main_Control_Unit ;


ARCHITECTURE struct OF Main_Control_Unit IS

BEGIN

-- Insert your code here --
   ---------------------------------------------------------------------------
process1: PROCESS(Instruction_31_26, Instruction_5_0)
---------------------------------------------------------------------------
BEGIN
-- Default Values --
RegDst <= '0';
ALUSrc <= '0';
MemToReg <= '0';
RegWrite <= '0';
MemRead <= '0';
MemWrite <= '0';
Beq <= '0';
Bne <= '0';
ALUOp <= "00";
J <= '0';
Jal <= '0';
Jr <= '0';   
   CASE Instruction_31_26 IS
   WHEN "000000" =>                         -- jr/R-Type
      IF Instruction_5_0 = "001000" THEN    -- Jr
        Jr <= '1';
      ELSE                  -- R-Type
        RegDst <= '1';
        RegWrite <= '1';
        ALUOp <= "10";
      END IF;
   WHEN "100011" =>        -- lw
      ALUSrc <= '1';
      MemToReg <= '1';
      RegWrite <= '1';
      MemRead <= '1';
   WHEN "101011" =>        -- sw
      ALUSrc <= '1';
      MemWrite <= '1';
   WHEN "000100" =>        -- beq
      Beq <= '1';
      ALUOp <= "01";
   WHEN "000101" =>        -- bne 
      Bne <= '1';
      ALUOp <= "01";    
   WHEN "000010" =>        -- j
      J <= '1';
   WHEN "000011" =>        -- jal 
      Jal <= '1';
      RegWrite <= '1';
   WHEN "001000" =>        -- addi
      ALUSrc <= '1';
      RegWrite <= '1';
   WHEN OTHERS => NULL;
   END CASE;
END PROCESS process1;
---------------------------

END struct;
