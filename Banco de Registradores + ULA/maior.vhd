LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY maior IS
    PORT (
        x, y : IN unsigned(15 DOWNTO 0);
        maior_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_maior OF maior IS
BEGIN
    maior_out <= x WHEN x > y ELSE
        y WHEN x <= y ELSE
        "0000000000000000"; -- menor ou igual a y
END ARCHITECTURE;