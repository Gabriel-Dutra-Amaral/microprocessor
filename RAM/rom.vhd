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
        1 => B"0101_1_01111_111_000", -- MOV A,15
        2 => B"0101_0_00000_010_111", -- MOV R2,A
        3 => B"0101_1_01010_101_000", -- MOV R5,10
        4 => B"1000_01_0000_101_010", -- LDS R5, (R2) -- RAM[R2] <= R5
        5 => B"1000_10_0000_011_010", -- LDL R3, (R2) -- R3 <= RAM[R2]
        6 => B"0101_1_01001_100_000", -- MOV R4,9
        7 => B"1000_01_0000_100_101", -- LDS R4, (R5) -- RAM[R5] <= R4
        8 => B"1000_10_0000_110_101", -- LDL R6, (R5) -- R6 <= RAM[R5]
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