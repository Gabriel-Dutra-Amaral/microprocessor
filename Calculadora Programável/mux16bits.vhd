LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux16bits IS
        PORT (
                entr0 : IN unsigned(15 DOWNTO 0);
                entr1 : IN unsigned(15 DOWNTO 0);
                entr2 : IN unsigned(15 DOWNTO 0);
                entr3 : IN unsigned(15 DOWNTO 0);
                entr4 : IN unsigned(15 DOWNTO 0);
                sel : IN unsigned(2 DOWNTO 0);
                saida : OUT unsigned(15 DOWNTO 0)
        );
END ENTITY;

ARCHITECTURE a_mux16bits OF mux16bits IS

BEGIN

        saida <= entr0 WHEN sel = "000" ELSE
                entr1 WHEN sel = "001" ELSE
                entr2 WHEN sel = "010" ELSE
                entr3 WHEN sel = "011" ELSE
                entr4 WHEN sel = "100" ELSE
                "0000000000000000";

END ARCHITECTURE;