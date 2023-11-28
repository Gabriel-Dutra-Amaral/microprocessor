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
        ------ Povoando a ram com os valores 1,2,3 ... 32.                         
        1 => B"0101_1_00000_111_000", -- MOV A,0 
        2 => B"0011_1_00100000_000", -- ADD A, 32
        3 => B"0101_0_00000_010_111", -- MOV R2,A
        4 => B"0101_1_00000_111_000", -- MOV A,0                      
        5 => B"0011_1_00000001_000", -- ADD A, 1                        
        6 => B"0101_0_00000_001_111", -- MOV R1, A                      
        7 => B"1000_01_0000_001_001", -- LDS R1, [R1]                   
        8 => B"0101_0_00000_111_001", -- MOV A, R1                      
        9 => B"0110_0_00000_111_010", -- CP A, R2                       
        10 => B"0111_00000_1111011", -- JRULT INST. 4 [10 + (-5) => 5]

        -- Eliminar valor 1:
        11 => B"0101_1_00001_111_000", -- MOV A,1
        12 => B"0101_0_00000_010_111", -- MOV R2,A-> R2 = 1
        13 => B"1000_01_0000_000_010", -- LDS R0, [R2]

        -- Elimina multiplos de 2:
        14 => B"0101_1_00010_111_000", -- MOV A,2
        15 => B"0101_0_00000_001_111", -- MOV R1,A -- Contador
        16 => B"0101_1_11111_111_000", -- MOV A,31
        17 => B"0011_1_00000010_000", -- ADD A,2 -> 33 -> max
        18 => B"0101_0_00000_010_111", -- MOV R2,A -- Limite superior -> 33
        19 => B"0101_0_00000_111_000", -- MOV A,R0
        20 => B"0101_0_00000_011_111", -- MOV R3,A -- LSB 0 -> Mult. 2
        21 => B"0101_1_00010_111_000", -- MOV A,2
        22 => B"0101_0_00000_100_111", -- MOV R4,A -- Incremento

        23 => B"0101_0_00000_111_001", -- MOV A,R1 -- Carrega contador [Inic: 2]
        24 => B"0011_0_00000000_100", -- ADD A,R4 -- Incremento [2]
        25 => B"0101_0_00000_001_111", -- MOV R1,A -- Atualiza contador [4]
        26 => B"1010_0_00000_111_011", -- AND A,R3
        27 => B"1001_00000_0000100", -- JREQ -> 27 + 4 = 31
        28 => B"0110_0_00000_111_010", -- CP A, R2 -- Compara com limite superior
        29 => B"0111_00000_1111010", -- JRULT INST. -> 29-6 = 23
        30 => B"0010_00_0000100001", -- JP 33

        31 => B"1000_01_0000_000_001", -- LDS R0, [R1]
        32 => B"0010_00000_0011100", -- JP 28

        33 => B"0001_000000000000", -- NOP

        -- Elimina multiplos de 3:
        34 => B"0101_1_00011_111_000", -- MOV A,3
        35 => B"0101_0_00000_001_111", -- MOV R1,A -- Contador
        36 => B"0101_1_11111_111_000", -- MOV A,31
        37 => B"0011_1_00000010_000", -- ADD A,2 -> 33 -> max
        38 => B"0101_0_00000_010_111", -- MOV R2,A -- Limite superior -> 33
        39 => B"0101_1_00001_111_000", -- MOV A,1
        40 => B"0101_0_00000_011_111", -- MOV R3,A -- LSB 1 -> Mult. 3
        45 => B"0101_1_00011_111_000", -- MOV A,3
        46 => B"0101_0_00000_100_111", -- MOV R4,A -- Incremento

        47 => B"0101_0_00000_111_001", -- MOV A,R1 -- Carrega contador [Inic: 3]
        48 => B"0011_0_00000000_100", -- ADD A,R4 -- Incremento [3]
        49 => B"0101_0_00000_001_111", -- MOV R1,A -- Atualiza contador [6]
        50 => B"0110_0_00000_111_010", -- CP A, R2 -- Compara com limite superior
        51 => B"0111_00000_0000010", -- JRULT INST. -> 51+2 = 53
        52 => B"0010_00_0000110111", -- JP 55

        53 => B"1000_01_0000_000_001", -- LDS R0, [R1]
        54 => B"0010_00000_0101111", -- JP 47

        55 => B"0001_000000000000", -- NOP

        -- Elimina multiplos de 5:
        56 => B"0101_1_00101_111_000", -- MOV A,5
        57 => B"0101_0_00000_001_111", -- MOV R1,A -- Contador
        58 => B"0101_1_11111_111_000", -- MOV A,31
        59 => B"0011_1_00000010_000", -- ADD A,2 -> 33 -> max
        60 => B"0101_0_00000_010_111", -- MOV R2,A -- Limite superior -> 33
        61 => B"0101_1_00001_111_000", -- MOV A,1
        62 => B"0101_0_00000_011_111", -- MOV R3,A -- LSB 1 -> Mult. 5
        63 => B"0101_1_00101_111_000", -- MOV A,5
        64 => B"0101_0_00000_100_111", -- MOV R4,A -- Incremento

        65 => B"0101_0_00000_111_001", -- MOV A,R1 -- Carrega contador [Inic: 5]
        66 => B"0011_0_00000000_100", -- ADD A,R4 -- Incremento [5]
        67 => B"0101_0_00000_001_111", -- MOV R1,A -- Atualiza contador [10]
        68 => B"0110_0_00000_111_010", -- CP A, R2 -- Compara com limite superior
        69 => B"0111_00000_0000010", -- JRULT INST. -> 69+2 = 71
        70 => B"0010_00000_1001001", -- JP 73

        71 => B"1000_01_0000_000_001", -- LDS R0, [R1]
        72 => B"0010_00000_1000001", -- JP 65

        73 => B"0001_000000000000", -- NOP

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