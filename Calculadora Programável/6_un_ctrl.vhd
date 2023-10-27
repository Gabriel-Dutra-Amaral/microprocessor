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
        saida_de_instrucao : OUT unsigned(15 DOWNTO 0);
        sel_mux_ula : OUT STD_LOGIC;
        sel_op_ula : OUT unsigned(1 DOWNTO 0);
        select_reg1_banco : OUT unsigned(2 DOWNTO 0);
        select_reg2_banco : OUT unsigned(2 DOWNTO 0);
        valor_imediato_op : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_un_ctrl OF un_ctrl IS

    COMPONENT maquina_de_estados IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            estado : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL state : STD_LOGIC := '0';
    SIGNAL opcode : unsigned(3 DOWNTO 0) := "0000";
    SIGNAL saida_endereco : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL registrador_instr : unsigned(2 downto 0) := "000";
    SIGNAL imm_op : unsigned(15 downto 0) := "0000000000000000";

BEGIN

    state_mac : maquina_de_estados PORT MAP(
        clk => clk,
        rst => rst,
        estado => state
    );
    --FETCH
    wr_en_pc <= '1' WHEN state = '1' ELSE
        '0';

    --DECODE
    saida_de_instrucao <= leitura_de_instrucao;
    opcode <= leitura_de_instrucao(15 DOWNTO 12); -- 4-bit MSB com os opcodes
    registrador_instr <= leitura_de_instrucao(2 DOWNTO 0); -- 3-bit LSB
    saida_endereco <= leitura_de_instrucao(9 DOWNTO 0); -- Visualizar entrada
    imm_op <= "0000" & leitura_de_instrucao(11 DOWNTO 0);

    -- Salto Incondicional

    seletor_jump <= '1' WHEN opcode = "0001" ELSE
        '0';

    saida_jump <= saida_endereco WHEN opcode = "0001";

    -- Fim Salto Incondicional

    -- ADD A, reg

    sel_op_ula <= "10" WHEN opcode = "0010";

    select_reg1_banco <= "111" WHEN opcode = "0010"; -- Acumulador

    sel_mux_ula <= '0' WHEN opcode = "0010"; -- Usa o registrador

    select_reg2_banco <= registrador_instr WHEN opcode = "0010"; -- Registrador

    -- wr_en_banco <= '1' WHEN opcode = "0010"; -- Saida do banco enable

    -- Fim ADD A, reg

    -- ADD A, imm

    sel_op_ula <= "10" WHEN opcode = "0011";

    select_reg1_banco <= "111" WHEN opcode = "0011"; -- Acumulador

    sel_mux_ula <= '1' WHEN opcode = "0011"; -- Usa imediato

    valor_imediato_op <= imm_op WHEN opcode = "0011"; -- Saida da ULA

    -- wr_en_banco <= '1' WHEN opcode = "0011"; -- Saida do banco enable

    -- Fim ADD A, imm

    -- SUB A, reg

    sel_op_ula <= "11" WHEN opcode = "0100";

    select_reg1_banco <= "111" WHEN opcode = "0100"; -- Acumulador

    sel_mux_ula <= '0' WHEN opcode = "0100"; -- Usa o registrador

    select_reg2_banco <= registrador_instr WHEN opcode = "0100"; -- Registrador

    -- wr_en_banco <= '1' WHEN opcode = "0100"; -- Saida do banco enable

    --FIM SUB A, reg

    -- SUB A, imm

    sel_op_ula <= "11" WHEN opcode = "0101";

    select_reg1_banco <= "111" WHEN opcode = "0101"; -- Acumulador

    sel_mux_ula <= '1' WHEN opcode = "0101"; -- Usa o imediato

    valor_imediato_op <= imm_op WHEN opcode = "0101"; -- Saida da ULA

    -- wr_en_banco <= '1' WHEN opcode = "0101"; -- Saida do banco enable

    --FIM SUB A, imm



END ARCHITECTURE;