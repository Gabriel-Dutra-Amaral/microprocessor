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
        0 => B"0000_000000000000", -- NOP
        1 => B"1000_1_00000_111_000", -- MOV A,0
        2 => B"1000_0_00000_011_111", -- MOV R3,A
        3 => B"1000_1_00000_111_000", -- MOV A,0
        4 => B"1000_0_00000_100_111", -- MOV R4,A
        5 => B"1000_1_00000_111_000", -- MOV A,0
        6 => B"0010_0_00000_111_011", -- ADD A,R3
        7 => B"0010_0_00000_111_100", -- ADD A,R4
        8 => B"1000_0_00000_100_111", -- MOV R4,A
        9 => B"1000_0_00000_111_011", -- MOV A,R3
        10 => B"0010_1_00001_111_000", -- ADD A, 1
        11 => B"1000_0_00000_011_111", -- MOV R3,A
        12 => B"1000_0_00000_111_011", -- MOV A, R3
        20 => B"0110_1_11110_111_000", -- CP A, 30
        21 => B"1001_00_1111100000", -- JRULT INST 5 (21-16[1111100000]=5)
        22 => B"1000_0_00000_111_100", -- MOV A, R4
        23 => B"1000_0_00000_101_111", -- MOV R5, A
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