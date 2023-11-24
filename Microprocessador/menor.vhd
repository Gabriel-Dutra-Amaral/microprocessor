LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY menor IS
    PORT (
        x, y : IN unsigned(15 DOWNTO 0);
        menor_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_menor OF menor IS
BEGIN
    menor_out <= x WHEN x < y ELSE
        y WHEN y <= x ELSE
        "0000000000000000"; -- maior ou igual a y

END ARCHITECTURE;