LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY somador IS
   PORT (
      entrada : IN unsigned(6 DOWNTO 0);
      saida : OUT unsigned(6 DOWNTO 0)
   );
END ENTITY;

ARCHITECTURE a_somador OF somador IS
BEGIN
   PROCESS(entrada)
   BEGIN
      saida <= entrada + 1;
   END PROCESS;
END ARCHITECTURE;