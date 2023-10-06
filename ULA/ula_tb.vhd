LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula_tb IS
END ENTITY;

ARCHITECTURE a_ula_tb OF ula_tb IS
    COMPONENT ula IS
        PORT (
            entrada_0, entrada_1 : IN unsigned(15 DOWNTO 0);
            seletor_op : IN unsigned(1 DOWNTO 0);
            saida_ula : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL entrada_0 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL entrada_1 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL seletor_op : unsigned(1 DOWNTO 0) := "00";
    SIGNAL saida_ula : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN
    uut : ula PORT MAP(
        entrada_0 => entrada_0,
        entrada_1 => entrada_1,
        seletor_op => seletor_op,
        saida_ula => saida_ula
    );

    PROCESS
    BEGIN
        seletor_op <= "10"; --testando a soma
        entrada_0 <= "0000000000001111"; -- verificar estouro
        entrada_1 <= "0000000000001010"; -- somar negativos
        WAIT FOR 50 ns;
        entrada_0 <= "0000000000001001";
        entrada_1 <= "0000000000001000";
        WAIT FOR 50 ns;
        entrada_0 <= "0000000000001011";
        entrada_1 <= "0000000000001010";
        WAIT FOR 50 ns;
        entrada_0 <= "0000000000000111";
        entrada_1 <= "0000000000000010";
        WAIT FOR 50 ns;
        entrada_0 <= "0000000000000010";
        entrada_1 <= "0000000000000010";
        WAIT FOR 50 ns;
        entrada_0 <= "0000000000000111";
        entrada_1 <= "0000000000000010";
        wait for 50 ns;

        seletor_op <= "11"; -- testando a subtração
        entrada_0 <= "0000000000001111";
		entrada_1 <= "0000000000001010";
		WAIT FOR 50 ns;
		entrada_0 <= "0000000000001001";
		entrada_1 <= "0000000000001000";
		WAIT FOR 50 ns;
		entrada_0 <= "0000000000001011";
		entrada_1 <= "0000000000001010";
		WAIT FOR 50 ns;
		entrada_0 <= "0000000000000111";
		entrada_1 <= "0000000000000010";
		WAIT FOR 50 ns;
		entrada_0 <= "0000000000000010";
		entrada_1 <= "0000000000001111";
        wait for 50 ns;

        seletor_op <= "00"; -- testando comparação maior
        entrada_0 <= "1000000000000000";
        entrada_1 <= "0000000000001010";
        WAIT FOR 50 ns;
        entrada_0 <= "0000000100000000";
        entrada_1 <= "0000000000001001";
        WAIT FOR 50 ns;
        entrada_0 <= "0000000000001010";
        entrada_1 <= "0000000000001010";
        WAIT FOR 50 ns;
        entrada_0 <= "0000000000000111";
        entrada_1 <= "0000000000000010";
        WAIT FOR 50 ns;
        entrada_0 <= "0000000000001111";
        entrada_1 <= "0000000000000010";
        wait for 50 ns;

        seletor_op <= "01"; --testando comparação menor
        entrada_0 <= "0000000000001111";
        entrada_1 <= "0000000000001010";
        WAIT FOR 50 ns;
        entrada_0 <= "0000000000001000";
        entrada_1 <= "0000000000001001";
        WAIT FOR 50 ns;
        entrada_0 <= "0000000000001010";
        entrada_1 <= "0000000000001010";
        WAIT FOR 50 ns;
        entrada_0 <= "0000000000000111";
        entrada_1 <= "0000000000000010";
        WAIT FOR 50 ns;
        entrada_0 <= "0000000000001111";
        entrada_1 <= "0000000000000010";
        wait for 50 ns;
        WAIT;
    END PROCESS;
END ARCHITECTURE;