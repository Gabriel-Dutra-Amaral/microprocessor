LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY maquina_de_estados IS
   PORT (
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      estado: OUT UNSIGNED(1 DOWNTO 0)
   );
END ENTITY;

ARCHITECTURE a_maquina_de_estados OF maquina_de_estados IS
   SIGNAL estado_s : unsigned(1 DOWNTO 0);
BEGIN
   PROCESS (clk, rst) -- acionado se houver mudança em clk, rst 
   BEGIN
      IF rst = '1' THEN
         estado_s <= "00";
         ELSIF rising_edge(clk) THEN
            IF estado_s =  "10" THEN -- se agora esta em 2
                estado_s <= "00"; --o prox vai voltar ao zero
            else
                estado_s <= estado_s + 1; -- senao avanca
         END IF;
      END IF;
   END PROCESS;

   estado <= estado_s; 
END ARCHITECTURE;