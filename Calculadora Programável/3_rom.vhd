LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom IS
    PORT (
        clk : IN STD_LOGIC;
        entrada_rom : IN unsigned(9 DOWNTO 0); -- 2^10 = 1024
        saida_rom_dado : OUT unsigned(15 DOWNTO 0) -- Tamanho da instrucao
    );
END ENTITY;

ARCHITECTURE a_rom OF rom IS
    TYPE mem IS ARRAY (0 TO 640) OF unsigned(15 DOWNTO 0); -- 640 Bytes na EEPROM
    CONSTANT conteudo_rom : mem := (
        0 => "1001110100000000", -- NOP -> OPCODE -> 9D -> 1001 1101
        1 => "1111110000010000", -- JUMP -> OPCODE -> FC -> 1111 1100 - endereco depois
        2 => "0000000000000011",
        3 => "0000000000000100",
        4 => "1000000000000001",
        5 => "1111110001111111",
        6 => "1111000000110000",
        7 => "0000000000000001",
        8 => "0000000000000001",
        9 => "0000000000000000",
        10 => "0000000000000000",
        15 => "1111100000000101",
        16 => "0000000000010000",
        17 => "0000000000010001",
        18 => "0000000000010010",
        19 => "0000000000010011",
        20 => "0000000000010100",
        639 => "1000100010001000", -- Ultimo endereço -> 8888
        OTHERS => (OTHERS => '0')
    );
BEGIN
    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            saida_rom_dado <= conteudo_rom(to_integer(entrada_rom));
        END IF;
    END PROCESS;
END ARCHITECTURE;