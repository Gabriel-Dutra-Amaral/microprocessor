LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY subtr IS
    PORT (
        x, y : IN unsigned(15 DOWNTO 0);
        subtr_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_subtr OF subtr IS
BEGIN
    subtr_out <= x - y;
END ARCHITECTURE;