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
        1 => B"0101_1_00001_111_000", -- MOV A,1
        2 => B"0101_0_00000_010_111", -- MOV R2,A -> valor
        3 => B"0101_1_00010_111_000", -- MOV A,3
        4 => B"",
        OTHERS => (OTHERS => '0')
    );

BEGINcomo saber se um numero é multiplo de 2 sem usar divisao

    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            saida_rom_dado <= conteudo_rom(to_integer(entrada_rom));
        END IF;
    END PROCESS;

END ARCHITECTURE;