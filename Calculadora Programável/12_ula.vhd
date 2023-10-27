LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula IS
    PORT (
        entrada_0, entrada_1 : IN unsigned(15 DOWNTO 0);
        seletor_op : IN unsigned(1 DOWNTO 0);
        saida_ula : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_ula OF ula IS

    COMPONENT maior IS
        PORT (
            x : IN unsigned(15 DOWNTO 0);
            y : IN unsigned(15 DOWNTO 0);
            maior_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT menor IS
        PORT (
            x : IN unsigned(15 DOWNTO 0);
            y : IN unsigned(15 DOWNTO 0);
            menor_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux16bits IS
        PORT (
            entr0 : IN unsigned(15 DOWNTO 0);
            entr1 : IN unsigned(15 DOWNTO 0);
            entr2 : IN unsigned(15 DOWNTO 0);
            entr3 : IN unsigned(15 DOWNTO 0);
            sel : IN unsigned(1 DOWNTO 0);
            saida : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT soma IS
        PORT (
            x : IN unsigned(15 DOWNTO 0);
            y : IN unsigned(15 DOWNTO 0);
            soma_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT subtr IS
        PORT (
            x : IN unsigned(15 DOWNTO 0);
            y : IN unsigned(15 DOWNTO 0);
            subtr_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL maior_operac_0 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL menor_operac_1 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL soma_operac_2 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL subtr_operac_3 : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN
    maior1 : maior PORT MAP(x => entrada_0, y => entrada_1, maior_out => maior_operac_0);
    menor1 : menor PORT MAP(x => entrada_0, y => entrada_1, menor_out => menor_operac_1);
    soma1 : soma PORT MAP(x => entrada_0, y => entrada_1, soma_out => soma_operac_2);
    subtr1 : subtr PORT MAP(x => entrada_0, y => entrada_1, subtr_out => subtr_operac_3);
    mux16bits1 : mux16bits PORT MAP(
        entr0 => maior_operac_0,
        entr1 => menor_operac_1,
        entr2 => soma_operac_2,
        entr3 => subtr_operac_3,
        sel => seletor_op,
        saida => saida_ula);
END ARCHITECTURE;