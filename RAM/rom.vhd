LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom IS
    PORT (
        clk : IN STD_LOGIC;
        entrada_rom : IN unsigned(6 DOWNTO 0);
        saida_rom_dado : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_rom OF rom IS

    TYPE mem IS ARRAY (0 TO 127) OF unsigned(15 DOWNTO 0);
    
    CONSTANT conteudo_rom : mem := (
        0 => B"0001_000000000000", -- NOP
        1 => B"0101_1_00001_001_000", -- MOV R1, 1
        2 => B"0101_1_01111_010_000", -- MOV R2, 15
        3 => B"0101_1_10111_011_000", -- MOV R3, 23
        4 => B"0101_1_00111_100_000", -- MOV R4, 7
        5 => B"1000_01_0000_011_001", -- LDS R3, (R1) -- RAM[R1] <= R3
        6 => B"1000_01_0000_100_010", -- LDS R4, (R2) -- RAM[R2] <= R4
        7 => B"1000_01_0000_010_011", -- LDS R2, (R3) -- RAM[R3] <= R2
        8 => B"1000_10_0000_101_011", -- LDL R5, (R3) -- R5 <= RAM[R3]
        9 => B"0101_1_11110_110_000", -- MOV R6, 30
        10 => B"1000_01_0000_001_110", -- LDS R1, (R6) -- RAM[R6] <= R1
        11 => B"1000_10_0000_111_110", -- LDL R7, (R6) -- R7 <= RAM[R6]
        12 => B"1000_10_0000_001_001", -- LDL R1, (R1) -- R1 <= RAM[R1]
        --13 => B"0011_1_00000001_000", -- ADD A, 1
        --14 => B"0011_0_00000001_001", -- ADD A, R1
        --15 => B"0101_0_00000_010_110", -- MOV R2, R6
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