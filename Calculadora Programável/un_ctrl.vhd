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
        seletor_ula : OUT unsigned(1 DOWNTO 0);
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
    SIGNAL jump_address : unsigned(9 DOWNTO 0) := "0000000000";

    -- Banco de registradores --
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

    saida_jump <= jump_address WHEN opcode = "0001" AND estado_maq = "10" ELSE
        "0000000000";

    -- ADD A, reg --

    seletor_ula <= "10" WHEN (opcode = "0010" AND estado_maq = "10") ELSE
        "00";

    reg1 <= "111" WHEN (opcode = "0010" AND estado_maq = "10") ELSE
        "000";

    reg2 <= registrador_instr WHEN (opcode = "0010" AND estado_maq = "10") ELSE
        "000";

    salvar_resultado <= '1' WHEN (opcode = "0010" AND estado_maq = "10") ELSE
        '0';

    salva_registrador <= "111" WHEN (opcode = "0010" AND estado_maq = "10") ELSE
        "000";

    -- ADD A, imm --

    imediato_op <= '1' WHEN (opcode = "0011" AND estado_maq = "10") ELSE
        '0';

    seletor_ula <= "10" WHEN (opcode = "0011" AND estado_maq = "10");

    reg1 <= "111" WHEN (opcode = "0011" AND estado_maq = "10");

    valor_imediato_op <= imm_op WHEN (opcode = "0011" AND estado_maq = "10") ELSE
        "0000000000000000";

    salvar_resultado <= '1' WHEN (opcode = "0011" AND estado_maq = "10") ELSE
        '0';

    salva_registrador <= "111" WHEN (opcode = "0011" AND estado_maq = "10") ELSE
        "000";

    --sel_k_reg <= '1' WHEN opcode = "0011"; -- Usa imediato

    --controle_mov <= '0' WHEN opcode = "0011";

    -- SUB A, reg

    --seletor_ula <= "11" WHEN opcode = "0100";

    --reg1 <= "111" WHEN opcode = "0100"; -- Acumulador

    --sel_k_reg <= '0' WHEN opcode = "0100"; -- Usa o registrador

    --reg2 <= registrador_instr WHEN opcode = "0100"; -- Registrador

    --controle_mov <= '0' WHEN opcode = "0100";

    -- SUB A, imm

    --seletor_ula <= "11" WHEN opcode = "0101";

    --reg1 <= "111" WHEN opcode = "0101"; -- Acumulador

    --sel_k_reg <= '1' WHEN opcode = "0101"; -- Usa o imediato

    --valor_imediato_op <= imm_op WHEN opcode = "0101"; -- Saida da ULA

    --controle_mov <= '0' WHEN opcode = "0101";

    -- MOV dst,src

    --reg1 <= leitura_de_instrucao(2 DOWNTO 0) WHEN opcode = "1000";

    --reg2 <= leitura_de_instrucao(5 DOWNTO 3) WHEN opcode = "1000";

    --controle_mov <= '1' WHEN opcode = "1000";

    -- Selecao do registrador a ser escrito no banco

    --select_reg1_banco <= reg1;
    --select_reg2_banco <= reg2;

    --operacao da ula
    --sel_op_ula <= seletor_ula;

    --constante ou registrador
    --sel_mux_ula <= sel_k_reg;

    --EXECUTE 
    --write_reg <= '1' WHEN state = '1' AND (opcode = "1000" OR opcode = "0100" OR opcode = "0010") ELSE
    --    '0';

    --wr_reg <= write_reg;

END ARCHITECTURE;