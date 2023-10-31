LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY soma IS
    PORT (
        x, y : IN unsigned(15 DOWNTO 0);
        soma_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_soma OF soma IS
BEGIN
    soma_out <= x + y;
END ARCHITECTURE;