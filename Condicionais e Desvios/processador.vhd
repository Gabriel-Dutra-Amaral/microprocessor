LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY processador IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        estado : OUT unsigned(1 DOWNTO 0);
        pc_saida : OUT unsigned(9 DOWNTO 0);
        registrador_de_instr : OUT unsigned(15 DOWNTO 0);
        saida_banco_reg1 : OUT unsigned(15 DOWNTO 0);
        saida_banco_reg2 : OUT unsigned(15 DOWNTO 0);
        saida_da_ula : OUT unsigned(15 DOWNTO 0)

    );
END ENTITY;

ARCHITECTURE a_processador OF processador IS

    COMPONENT pc IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            wr_en : IN STD_LOGIC;
            endereco_entrada_pc : IN unsigned(9 DOWNTO 0);
            endereco_saida_pc : OUT unsigned(9 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT converte IS
        PORT (
            num_complemento_dois : IN unsigned(9 DOWNTO 0);
            num_normal : OUT unsigned(9 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT somador IS
        PORT (
            entrada_somador : IN unsigned(9 DOWNTO 0);
            saida_somador : OUT unsigned(9 DOWNTO 0)
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

            saida_jrult : OUT unsigned(9 DOWNTO 0); -- Cond BLT
            seletor_jrult : OUT STD_LOGIC; -- Cond BLT
            soma_ou_sub_jrult : OUT STD_LOGIC; -- Cond BLT

            reg1 : OUT unsigned(2 DOWNTO 0);
            reg2 : OUT unsigned(2 DOWNTO 0);
            wr_result_en : OUT STD_LOGIC;
            register_code : OUT unsigned(2 DOWNTO 0);
            valor_imediato_op : OUT unsigned(15 DOWNTO 0);
            seletor_ula : OUT unsigned(2 DOWNTO 0);
            imediato_op : OUT STD_LOGIC;
            saida_estado : OUT unsigned(1 DOWNTO 0);
            flag_Carry_o : IN STD_LOGIC
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
            seletor_op : IN unsigned(2 DOWNTO 0);
            saida_ula : OUT unsigned(15 DOWNTO 0);
            out_flag_Carry : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Salto incondicional --
    SIGNAL wr_en_pc_uc : STD_LOGIC := '0';
    SIGNAL saida_rom : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL ctrl_salto : STD_LOGIC := '0';
    SIGNAL valor_jump : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL ctrl_jrult : STD_LOGIC := '0';
    SIGNAL valor_jrult : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL saida_pc : unsigned(9 DOWNTO 0) := "0000000000";

    -- Banco de Registradores --
    SIGNAL entrada_reg1 : unsigned(2 DOWNTO 0) := "000";
    SIGNAL entrada_reg2 : unsigned(2 DOWNTO 0) := "000";
    SIGNAL saida_reg1 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL saida_reg2 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL codigo_registrador : unsigned(2 DOWNTO 0) := "000";
    SIGNAL escreve_registrador : STD_LOGIC := '0';

    -- Unidade de Controle --
    SIGNAL valor_imediato_op : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL sel_mov_reg_imm : STD_LOGIC := '0';
    SIGNAL valor_do_estado : unsigned(1 DOWNTO 0) := "00";

    -- ULA --
    SIGNAL seleciona_op_ula : unsigned(2 DOWNTO 0) := "000";
    SIGNAL saida_ula : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL mux_reg_imm : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL eh_imediato : STD_LOGIC := '0';
    SIGNAL flag_C_s : STD_LOGIC := '0';

    -- Program Counter --
    SIGNAL mux_2x1x1_entrada_pc : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL saida_somador : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL saida_endereco_pc : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL demux_1x1x2 : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL soma_ou_sub_jrult : STD_LOGIC := '0';
    SIGNAL num_complemento_dois : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL num_normal : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL sub : unsigned(9 DOWNTO 0) := "0000000000";

BEGIN

    pc_0 : pc PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en_pc_uc,
        endereco_entrada_pc => mux_2x1x1_entrada_pc,
        endereco_saida_pc => saida_endereco_pc
    );

    sub <= (saida_endereco_pc - valor_jrult);

    converte_0 : converte PORT MAP(
        num_complemento_dois => sub,
        num_normal => num_normal
    );

    somador_0 : somador PORT MAP(
        entrada_somador => demux_1x1x2,
        saida_somador => saida_somador
    );

    demux_1x1x2 <= (saida_endereco_pc + valor_jrult) WHEN (ctrl_jrult = '1' AND soma_ou_sub_jrult = '0') ELSE
        num_normal WHEN (ctrl_jrult = '1' AND soma_ou_sub_jrult = '1') ELSE
        saida_endereco_pc;

    mux_2x1x1_entrada_pc <= valor_jump WHEN ctrl_salto = '1' ELSE
        saida_somador;

    rom_0 : rom PORT MAP(
        clk => clk,
        entrada_rom => saida_somador,
        saida_rom_dado => saida_rom
    );

    uc_0 : un_ctrl PORT MAP(
        leitura_de_instrucao => saida_rom,
        clk => clk,
        rst => rst,
        wr_en_pc => wr_en_pc_uc,
        seletor_jump => ctrl_salto,
        saida_jump => valor_jump,
        saida_jrult => valor_jrult,
        seletor_jrult => ctrl_jrult,
        soma_ou_sub_jrult => soma_ou_sub_jrult,
        reg1 => entrada_reg1,
        reg2 => entrada_reg2,
        wr_result_en => escreve_registrador,
        register_code => codigo_registrador,
        valor_imediato_op => valor_imediato_op,
        seletor_ula => seleciona_op_ula,
        imediato_op => eh_imediato,
        saida_estado => valor_do_estado,
        flag_Carry_o => flag_C_s
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

    mux_reg_imm <= saida_reg2 WHEN eh_imediato = '0' ELSE
        valor_imediato_op;

    ula_0 : ula PORT MAP(
        entrada_0 => saida_reg1,
        entrada_1 => mux_reg_imm,
        seletor_op => seleciona_op_ula,
        saida_ula => saida_ula,
        out_flag_carry => flag_C_s
    );

    estado <= valor_do_estado;
    pc_saida <= saida_somador;
    registrador_de_instr <= saida_rom;
    saida_banco_reg1 <= saida_reg1;
    saida_banco_reg2 <= saida_reg2;
    saida_da_ula <= saida_ula;

END ARCHITECTURE a_processador;