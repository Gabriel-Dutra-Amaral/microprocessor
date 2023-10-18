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
    process(entrada)
    begin
      
         IF entrada = "0000000" THEN
            saida <= "0000000";
         ELSE 
            saida <= entrada + 1;
         END IF;      
   
    end process;
END ARCHITECTURE;