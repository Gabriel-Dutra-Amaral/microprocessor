LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula IS
    PORT (
        entrada_0 : IN unsigned(15 DOWNTO 0);
        entrada_1 : IN unsigned(15 DOWNTO 0);
        seletor_op : IN unsigned(2 DOWNTO 0);

        saida_ula : OUT unsigned(15 DOWNTO 0);

        out_flag_carry : OUT STD_LOGIC;
        out_flag_zero : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE a_ula OF ula IS

    COMPONENT op_and IS
        PORT (
            x, y : IN unsigned(15 DOWNTO 0);
            and_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT menor IS
        PORT (
            x : IN unsigned(15 DOWNTO 0);
            y : IN unsigned(15 DOWNTO 0);
            menor_out : OUT unsigned(15 DOWNTO 0)
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

    COMPONENT mov IS
        PORT (
            x : IN unsigned(15 DOWNTO 0);
            y : IN unsigned(15 DOWNTO 0);
            mov_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT load IS
        PORT (
            x : IN unsigned(15 DOWNTO 0);
            y : IN unsigned(15 DOWNTO 0);
            load_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux16bits IS
        PORT (
            entr0 : IN unsigned(15 DOWNTO 0);
            entr1 : IN unsigned(15 DOWNTO 0);
            entr2 : IN unsigned(15 DOWNTO 0);
            entr3 : IN unsigned(15 DOWNTO 0);
            entr4 : IN unsigned(15 DOWNTO 0);
            entr5 : IN unsigned(15 DOWNTO 0);
            sel : IN unsigned(2 DOWNTO 0);
            saida : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL and_operac_0 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL menor_operac_1 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL soma_operac_2 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL subtr_operac_3 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL mov_operac_4 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL load_operac_5 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL zero : STD_LOGIC := '0';

BEGIN

    and1 : op_and PORT MAP(
        x => entrada_0,
        y => entrada_1,
        and_out => and_operac_0
    );

    menor1 : menor PORT MAP(
        x => entrada_0,
        y => entrada_1,
        menor_out => menor_operac_1
    );

    soma1 : soma PORT MAP(
        x => entrada_0,
        y => entrada_1,
        soma_out => soma_operac_2
    );

    subtr1 : subtr PORT MAP(
        x => entrada_0,
        y => entrada_1,
        subtr_out => subtr_operac_3
    );

    mov1 : mov PORT MAP(
        x => entrada_0,
        y => entrada_1,
        mov_out => mov_operac_4
    );

    load1 : load PORT MAP(
        x => entrada_0,
        y => entrada_1,
        load_out => load_operac_5
    );

    mux16bits1 : mux16bits PORT MAP(
        entr0 => and_operac_0,
        entr1 => menor_operac_1,
        entr2 => soma_operac_2,
        entr3 => subtr_operac_3,
        entr4 => mov_operac_4,
        entr5 => load_operac_5,
        sel => seletor_op,
        saida => saida_ula
    );

    zero <= entrada_0(0) AND entrada_1(0);

    out_flag_carry <= '1' WHEN entrada_0 < entrada_1 ELSE
    '0';

    out_flag_zero <= '1' WHEN (entrada_0 - entrada_1) = "0000000000000000" ELSE
    '1' WHEN zero = '0' ELSE
    '0';

END ARCHITECTURE;