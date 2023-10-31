LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY un_ctrl IS
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
        seletor_ula : OUT unsigned(2 DOWNTO 0);
        imediato_op : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE a_un_ctrl OF un_ctrl IS

    COMPONENT maquina_de_estados IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            estado : OUT unsigned(1 DOWNTO 0)
        );
    END COMPONENT;

    -- Unidade de Controle --
    SIGNAL estado_maq : unsigned(1 DOWNTO 0) := "00";
    SIGNAL imm_op : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL opcode : unsigned(3 DOWNTO 0) := "0000";
    SIGNAL entrada_uc : unsigned(15 DOWNTO 0) := "0000000000000000";

    -- Program Counter --
    SIGNAL endereco_de_salto : unsigned(9 DOWNTO 0) := "0000000000";

    -- Banco de Registradores --
    SIGNAL registrador_instr : unsigned(2 DOWNTO 0) := "000";

BEGIN

    state_mac : maquina_de_estados PORT MAP(
        clk => clk,
        rst => rst,
        estado => estado_maq
    );

    -- Decode --
    opcode <= leitura_de_instrucao(15 DOWNTO 12) WHEN estado_maq = "01";
    registrador_instr <= leitura_de_instrucao(2 DOWNTO 0) WHEN estado_maq = "01";
    imm_op <= "0000" & leitura_de_instrucao(11 DOWNTO 0) WHEN estado_maq = "01";

    -- Execute --
    wr_en_pc <= '1' WHEN estado_maq = "10" ELSE
        '0';

    -- Salto Incondicional
    seletor_jump <= '1' WHEN opcode = "0001" AND estado_maq = "10" ELSE
        '0';

    saida_jump <= endereco_de_salto WHEN (opcode = "0001" AND estado_maq = "10");

END ARCHITECTURE;