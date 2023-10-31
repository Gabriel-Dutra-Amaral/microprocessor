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
            saida_jump : OUT unsigned(9 DOWNTO 0);
            reg1 : OUT unsigned(2 DOWNTO 0);
            reg2 : OUT unsigned(2 DOWNTO 0);
            salvar_resultado : OUT STD_LOGIC;
            salva_registrador : OUT unsigned(2 DOWNTO 0);
            valor_imediato_op : OUT unsigned(15 DOWNTO 0);
            seletor_ula : OUT unsigned(1 DOWNTO 0);
            imediato_op : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT banco_de_registradores IS
        PORT (
            seleciona_registrador_1 : IN unsigned(2 DOWNTO 0);
            seleciona_registrador_2 : IN unsigned(2 DOWNTO 0);
            codigo_registrador : IN unsigned(2 DOWNTO 0);
            escreve_registrador : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            saida_registrador_1 : OUT unsigned(15 DOWNTO 0);
            saida_registrador_2 : OUT unsigned(15 DOWNTO 0);
            dado_registrador : IN unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ula IS
        PORT (
            entrada_0 : IN unsigned(15 DOWNTO 0);
            entrada_1 : IN unsigned(15 DOWNTO 0);
            seletor_op : IN unsigned(1 DOWNTO 0);
            saida_ula : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    -- Salto incondicional
    SIGNAL wr_en_pc_uc : STD_LOGIC := '0';
    SIGNAL saida_rom : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL ctrl_salto : STD_LOGIC := '0';
    SIGNAL valor_jump : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL saida_pc : unsigned(9 DOWNTO 0) := "0000000000";

    -- Banco de Registradores
    SIGNAL entrada_reg1 : unsigned(2 DOWNTO 0) := "000";
    SIGNAL entrada_reg2 : unsigned(2 DOWNTO 0) := "000";
    SIGNAL saida_reg1 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL saida_reg2 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL codigo_registrador : unsigned(2 DOWNTO 0) := "000";
    SIGNAL escreve_registrador : STD_LOGIC := '0';

    -- Unidade de Controle
    SIGNAL valor_imediato_op : unsigned(15 DOWNTO 0) := "0000000000000000";

    -- ULA
    SIGNAL seleciona_op_ula : unsigned(1 DOWNTO 0) := "00";
    SIGNAL saida_ula : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL mux_reg_imm : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL eh_imediato : STD_LOGIC := '0';

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
        saida_jump => valor_jump,
        reg1 => entrada_reg1,
        reg2 => entrada_reg2,
        salvar_resultado => escreve_registrador,
        salva_registrador => codigo_registrador,
        valor_imediato_op => valor_imediato_op,
        seletor_ula => seleciona_op_ula,
        imediato_op => eh_imediato
    );

    banco_0 : banco_de_registradores PORT MAP(
        seleciona_registrador_1 => entrada_reg1,
        seleciona_registrador_2 => entrada_reg2,
        codigo_registrador => codigo_registrador,
        escreve_registrador => escreve_registrador,
        clk => clk,
        rst => rst,
        saida_registrador_1 => saida_reg1,
        saida_registrador_2 => saida_reg2,
        dado_registrador => saida_ula
    );

    ula_0 : ula PORT MAP(
        entrada_0 => saida_reg1,
        entrada_1 => mux_reg_imm,
        seletor_op => seleciona_op_ula,
        saida_ula => saida_ula
    );

    mux_reg_imm <= saida_reg2 WHEN eh_imediato = '0' ELSE
        valor_imediato_op;

END ARCHITECTURE a_processador;