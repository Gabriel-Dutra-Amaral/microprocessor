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

    COMPONENT un_ctrl IS
        PORT (
            leitura_de_instrucao : IN unsigned(15 DOWNTO 0);
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            wr_en_pc : OUT STD_LOGIC;
            seletor_jump : OUT STD_LOGIC;
            saida_jump : OUT unsigned(9 DOWNTO 0)
        );
    END COMPONENT;

    -- Salto incondicional
    SIGNAL wr_en_pc_uc : STD_LOGIC := '0';
    SIGNAL saida_rom : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL ctrl_salto : STD_LOGIC := '0';
    SIGNAL valor_jump : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL saida_pc : unsigned(9 DOWNTO 0) := "0000000000";
    -- Fim salto incondicional

    

BEGIN

    pc_0 : pc_forward PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en_pc_uc,
        controle_de_salto => ctrl_salto,
        entrada_pc_forward => valor_jump,
        saida_pc_forward => saida_pc
    );

    rom_0 : rom PORT MAP(
        clk => clk,
        entrada_rom => saida_pc,
        saida_rom_dado => saida_rom
    );

    uc_0 : un_ctrl PORT MAP(
        leitura_de_instrucao => saida_rom,
        clk => clk,
        rst => rst,
        wr_en_pc => wr_en_pc_uc,
        seletor_jump => ctrl_salto,
        saida_jump => valor_jump
    );

END ARCHITECTURE a_processador;