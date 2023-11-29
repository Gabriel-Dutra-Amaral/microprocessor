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
        0 => B"1000_01_0000_000_000", -- LDS R0, [R0]
        -- Povoando a RAM com valores no intervalo de [1,32]                         
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
        15 => B"0101_0_00000_001_111", -- MOV R1,A -- Contador R1
        16 => B"0101_1_00000_111_000", -- MOV A,0 -- Zera A
        17 => B"0011_1_00100001_000", -- ADD A,33 -> 33 -> max
        18 => B"0101_0_00000_010_111", -- MOV R2,A -- Limite superior -> 33
        19 => B"0101_1_00000_111_000", -- MOV A,0 -- Zera A
        20 => B"0101_1_00010_111_000", -- MOV A,2
        21 => B"0101_0_00000_100_111", -- MOV R4,A -- Incremento R4

        22 => B"0101_0_00000_111_001", -- MOV A,R1 -- Carrega contador [Inic: 2]
        23 => B"0011_0_00000000_100", -- ADD A,R4 -- Incremento [2]
        24 => B"0101_0_00000_001_111", -- MOV R1,A -- Atualiza contador [4]
        25 => B"0110_0_00000_111_010", -- CP A, R2 -- Compara com limite superior
        26 => B"0111_00000_0000010", -- JRULT INST. -> 26+2 = 28
        27 => B"0010_00_0000011110", -- JP 30

        28 => B"1000_01_0000_000_001", -- LDS R0, [R1]
        29 => B"0010_00000_0010110", -- JP 22

        -- Elimina multiplos de 3:
        30 => B"0101_1_00011_111_000", -- MOV A,3
        31 => B"0101_0_00000_001_111", -- MOV R1,A -- Contador R1
        32 => B"0101_1_00000_111_000", -- MOV A,0 -- Zera A
        33 => B"0011_1_00100001_000", -- ADD A,33 -> 33 -> max
        34 => B"0101_0_00000_010_111", -- MOV R2,A -- Limite superior -> 33
        35 => B"0101_1_00011_111_000", -- MOV A,3
        36 => B"0101_0_00000_100_111", -- MOV R4,A -- Incremento R4

        37 => B"0101_0_00000_111_001", -- MOV A,R1 -- Carrega contador [Inic: 3]
        38 => B"0011_0_00000000_100", -- ADD A,R4 -- Incremento [3]
        39 => B"0101_0_00000_001_111", -- MOV R1,A -- Atualiza contador [6]
        40 => B"0110_0_00000_111_010", -- CP A, R2 -- Compara com limite superior
        41 => B"0111_00000_0000010", -- JRULT INST. -> 41+2 = 43
        42 => B"0010_00_0000101101", -- JP 45

        43 => B"1000_01_0000_000_001", -- LDS R0, [R1]
        44 => B"0010_00000_0100101", -- JP 37

        -- Elimina multiplos de 5:
        45 => B"0101_1_00101_111_000", -- MOV A,5
        46 => B"0101_0_00000_001_111", -- MOV R1,A -- Contador R1
        47 => B"0101_1_00000_111_000", -- MOV A,0 -- Zera A
        48 => B"0011_1_00100001_000", -- ADD A,33 -> 33 -> max
        49 => B"0101_0_00000_010_111", -- MOV R2,A -- Limite superior -> 33
        50 => B"0101_1_00101_111_000", -- MOV A,5
        51 => B"0101_0_00000_100_111", -- MOV R4,A -- Incremento R4

        52 => B"0101_0_00000_111_001", -- MOV A,R1 -- Carrega contador [Inic: 5]
        53 => B"0011_0_00000000_100", -- ADD A,R4 -- Incremento [5]
        54 => B"0101_0_00000_001_111", -- MOV R1,A -- Atualiza contador [10]
        55 => B"0110_0_00000_111_010", -- CP A, R2 -- Compara com limite superior
        56 => B"0111_00000_0000010", -- JRULT INST. -> 56+2 = 58
        57 => B"0010_00000_0111100", -- JP 60

        58 => B"1000_01_0000_000_001", -- LDS R0, [R1]
        59 => B"0010_00000_0110100", -- JP 52

        -- Elimina multiplos de 7:
        60 => B"0101_1_00111_111_000", -- MOV A,7
        61 => B"0101_0_00000_001_111", -- MOV R1,A -- Contador R1
        62 => B"0101_1_00000_111_000", -- MOV A,0 -- Zera A
        63 => B"0011_1_00100001_000", -- ADD A,33 -> 33 -> max
        64 => B"0101_0_00000_010_111", -- MOV R2,A -- Limite superior -> 33
        65 => B"0101_1_00111_111_000", -- MOV A,7
        66 => B"0101_0_00000_100_111", -- MOV R4,A -- Incremento R4

        67 => B"0101_0_00000_111_001", -- MOV A,R1 -- Carrega contador [Inic: 7]
        68 => B"0011_0_00000000_100", -- ADD A,R4 -- Incremento [7]
        69 => B"0101_0_00000_001_111", -- MOV R1,A -- Atualiza contador [14]
        70 => B"0110_0_00000_111_010", -- CP A, R2 -- Compara com limite superior
        71 => B"0111_00000_0000010", -- JRULT INST. -> 71+2 = 73
        72 => B"0010_00000_1001011", -- JP 75

        73 => B"1000_01_0000_000_001", -- LDS R0, [R1]
        74 => B"0010_00000_1000011", -- JP 67

        -- Elimina multiplos de 11:
        75 => B"0101_1_01011_111_000", -- MOV A,11
        76 => B"0101_0_00000_001_111", -- MOV R1,A -- Contador R1
        77 => B"0101_1_00000_111_000", -- MOV A,0 -- Zera A
        78 => B"0011_1_00100001_000", -- ADD A,33 -> 33 -> max
        79 => B"0101_0_00000_010_111", -- MOV R2,A -- Limite superior -> 33
        80 => B"0101_1_01011_111_000", -- MOV A,11
        81 => B"0101_0_00000_100_111", -- MOV R4,A -- Incremento R4

        82 => B"0101_0_00000_111_001", -- MOV A,R1 -- Carrega contador [Inic: 11]
        83 => B"0011_0_00000000_100", -- ADD A,R4 -- Incremento [11]
        84 => B"0101_0_00000_001_111", -- MOV R1,A -- Atualiza contador [22]
        85 => B"0110_0_00000_111_010", -- CP A, R2 -- Compara com limite superior
        86 => B"0111_00000_0000010", -- JRULT INST. -> 86+2 = 88
        87 => B"0010_00000_1011010", -- JP 90

        88 => B"1000_01_0000_000_001", -- LDS R0, [R1]
        89 => B"0010_00000_1010010", -- JP 82

        -- Limpa RAM[33]:
        -- 90 => B"0101_1_00000_111_000", -- MOV A,0
        -- 91 => B"0011_1_00100001_000", -- ADD A,33
        -- 92 => B"0101_0_00000_010_111", -- MOV R2,A-> R2 = 1
        -- 93 => B"1000_01_0000_000_010", -- LDS R0, [R2]

        -- Leitura dos valores da RAM                       
        94 => B"0101_1_00000_111_000", -- MOV A,0 
        95 => B"0011_1_00100000_000", -- ADD A, 32
        96 => B"0101_0_00000_010_111", -- MOV R2,A
        97 => B"0101_1_00001_111_000", -- MOV A,1             
        98 => B"0011_1_00000001_000", -- ADD A, 1                        
        99 => B"0101_0_00000_001_111", -- MOV R1, A  
        100 => B"0101_0_00000_110_111", -- MOV R6, A  -- Contador                    
        101 => B"1000_10_0000_001_001", -- LDL R1, [R1]                   
        102 => B"0101_0_00000_111_110", -- MOV A, R6                      
        103 => B"0110_0_00000_111_010", -- CP A, R2                       
        104 => B"0111_00000_1111010", -- JRULT INST. [-6]

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