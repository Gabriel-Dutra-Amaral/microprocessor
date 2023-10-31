LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY maquina_de_estados IS
   PORT (
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      estado : OUT STD_LOGIC
   );
END ENTITY;

ARCHITECTURE a_maquina_de_estados OF maquina_de_estados IS

   SIGNAL estado_s : STD_LOGIC;

BEGIN
   PROCESS (clk, rst)
   BEGIN
      IF rst = '1' THEN
         estado_s <= '0';
      ELSIF rising_edge(clk) THEN
         estado_s <= NOT estado_s;
      END IF;
   END PROCESS;

   estado <= estado_s;

END ARCHITECTURE;