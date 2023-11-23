LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY load IS
    PORT (
        x : IN unsigned(15 DOWNTO 0);
        y : IN unsigned(15 DOWNTO 0);
        load_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_load OF load IS
BEGIN
    load_out <= y;
END ARCHITECTURE;