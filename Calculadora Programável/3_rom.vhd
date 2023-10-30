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
        0 => "0011000000000101", -- ADD A, 5
        1 => "1000000000011111", -- MOV R3, A 
        2 => "0011000000000000", -- ADD A, 0
        3 => "0011000000001000", -- ADD A, 8
        4 => "1000000000100111", -- MOV R4, A
        5 => "0011000000000000", -- ADD A, 0
        6 => "0010000000000011", -- ADD A, R3
        7 => "0010000000000100", -- ADD A, R4
        8 => "1000000000101111", -- MOV R5, A
        9 => "0101000000000001", -- SUB A, 1
        10 => "1000000000101111", -- MOV R5, A
        11 => "0011000000000000", -- ADD A, 0
        15 => "0001000000010100", -- JP para end. 20
        20 => "1000000000011101", -- MOV R3, R5
        21 => "0001000000000110", -- JP para end.6 da inst 3
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