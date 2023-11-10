LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY converte_tb IS
END ENTITY;

ARCHITECTURE a_converte_tb OF converte_tb IS

    COMPONENT converte IS
        PORT (
            num_complemento_dois : IN unsigned(9 DOWNTO 0);
            num_normal : OUT unsigned(9 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL num_complemento_dois : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL num_normal : unsigned(9 DOWNTO 0) := "0000000000";

BEGIN

    compl_2 : converte PORT MAP(
        num_complemento_dois => num_complemento_dois,
        num_normal => num_normal
    );

    PROCESS
    BEGIN
        num_complemento_dois <= "1111100001";
        WAIT FOR 50 ns;
        WAIT;
    END PROCESS;

END ARCHITECTURE;