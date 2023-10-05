LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY decoder_3x8_tb IS
END ENTITY;

ARCHITECTURE a_decoder_3x8_tb OF decoder_3x8_tb IS
    COMPONENT decoder_3x8 IS
        PORT (
            write_register : IN unsigned(2 DOWNTO 0);
            write_enable : STD_LOGIC;
            saida : OUT unsigned(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL write_enable : STD_LOGIC := '0';
    SIGNAL write_register : unsigned(2 DOWNTO 0);
    SIGNAL saida : unsigned(7 DOWNTO 0);

BEGIN
    utt : decoder_3x8 PORT MAP(
        write_enable => write_enable,
        write_register => write_register,
        saida => saida
    );
    PROCESS
    BEGIN
        write_register <= "000";
        write_enable <= '0';
        WAIT FOR 50 ns;
        write_register <= "001";
        write_enable <= '1';
        WAIT FOR 50 ns;
        write_register <= "010";
        write_enable <= '0';
        WAIT FOR 50 ns;
        write_register <= "111";
        write_enable <= '1';
        WAIT FOR 50 ns;
        WAIT;
    END PROCESS;
END ARCHITECTURE;