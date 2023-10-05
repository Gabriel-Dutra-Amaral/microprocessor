LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY decoder_3x8 IS
    PORT (
        write_register : IN unsigned(2 DOWNTO 0);
        write_enable : STD_LOGIC;
        saida : OUT unsigned(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_decoder_3x8 OF decoder_3x8 IS
BEGIN
    saida <= "00000001" WHEN write_register = "000" AND write_enable = '1' ELSE
        "00000010" WHEN write_register = "001" AND write_enable = '1' ELSE
        "00000100" WHEN write_register = "010" AND write_enable = '1' ELSE
        "00001000" WHEN write_register = "011" AND write_enable = '1' ELSE
        "00010000" WHEN write_register = "100" AND write_enable = '1' ELSE
        "00100000" WHEN write_register = "101" AND write_enable = '1' ELSE
        "01000000" WHEN write_register = "110" AND write_enable = '1' ELSE
        "10000000" WHEN write_register = "111" AND write_enable = '1' ELSE
        "00000000";
END ARCHITECTURE;