LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY processador IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC
    );
END ENTITY;

ARCHITECTURE a_processador OF processador IS

    COMPONENT pc_forward IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            wr_en : IN STD_LOGIC;
            controle_de_salto : IN STD_LOGIC;
            entrada_pc_forward : IN unsigned(9 DOWNTO 0);
            saida_pc_forward : OUT unsigned(9 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT rom IS
        PORT (
            clk : IN STD_LOGIC;
            entrada_rom : IN unsigned(9 DOWNTO 0); -- 2^10 = 1024
            saida_rom_dado : OUT unsigned(15 DOWNTO 0) -- Tamanho da instrucao
        );
    END COMPONENT;

    
END ARCHITECTURE a_processador;