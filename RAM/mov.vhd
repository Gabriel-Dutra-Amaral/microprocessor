LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mov IS
    PORT (
        x : IN unsigned(15 DOWNTO 0);
        y : IN unsigned(15 DOWNTO 0);
        mov_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_mov OF mov IS
BEGIN
    mov_out <= y;
END ARCHITECTURE;