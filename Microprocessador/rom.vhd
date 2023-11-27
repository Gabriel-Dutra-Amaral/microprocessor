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
        11 => B"0101_1_00000_111_000", -- MOV A,0
        --12 => B"",
        --13 => B"",
        --14 => B"",
        --15 => B"",
           
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