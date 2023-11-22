LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY somador IS
   PORT (
      entrada_somador : IN unsigned(6 DOWNTO 0);
      saida_somador : OUT unsigned(6 DOWNTO 0)
   );
END ENTITY;

ARCHITECTURE a_somador OF somador IS
BEGIN
   saida_somador <= entrada_somador + 1;
END ARCHITECTURE;