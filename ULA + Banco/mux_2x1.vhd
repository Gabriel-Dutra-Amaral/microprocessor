LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux_2x1 IS
    PORT (
        sel0 : IN STD_LOGIC;
        entr0, entr1 : IN unsigned(15 DOWNTO 0);
        saida : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_mux_2x1 OF mux_2x1 IS
BEGIN
    saida <= entr0 WHEN sel0 = '0' ELSE
        entr1 WHEN sel0 = '1' ELSE
        "0000000000000000";
END ARCHITECTURE;