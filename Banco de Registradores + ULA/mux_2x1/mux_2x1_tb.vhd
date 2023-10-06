LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux_2x1_tb IS
END ENTITY;

ARCHITECTURE a_mux_2x1_tb OF mux_2x1_tb IS
    COMPONENT mux_2x1 IS
        PORT (
            sel0 : IN STD_LOGIC;
            entr0, entr1 : IN unsigned(15 DOWNTO 0);
            saida : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL entr0, entr1 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL saida : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL sel0 : STD_LOGIC := '0';

BEGIN

    utt : mux_2x1 PORT MAP(
        sel0 => sel0,
        entr0 => entr0,
        entr1 => entr1,
        saida => saida
    );

    PROCESS
    BEGIN
        entr0 <= "0000000000000001";
        entr1 <= "0000000000000010";
        sel0 <= '0';
        WAIT FOR 50 ns;
        entr0 <= "0000000000000001";
        entr1 <= "0000000000000010";
        sel0 <= '1';
        WAIT FOR 50 ns;
        entr0 <= "0000000000001111";
        entr1 <= "0000000000001010";
        sel0 <= '0';
        WAIT FOR 50 ns;
        WAIT;
    END PROCESS;
END ARCHITECTURE;