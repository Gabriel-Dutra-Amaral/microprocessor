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
        saida_jump : OUT unsigned(9 DOWNTO 0)
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

    SIGNAL state, write_reg, sel_k_reg : STD_LOGIC := '0';
    SIGNAL opcode : unsigned(3 DOWNTO 0) := "0000";
    SIGNAL saida_endereco : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL registrador_instr, reg1, reg2 : unsigned(2 DOWNTO 0) := "000";
    SIGNAL imm_op : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL data1, mux_2x1_banco, mux_2x1_ula, data2, ula_out : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL seletor_ula : unsigned(1 DOWNTO 0);

BEGIN

    state_mac : maquina_de_estados PORT MAP(
        clk => clk,
        rst => rst,
        estado => state
    );

    --FETCH

    wr_en_pc <= '1' WHEN state = '0' ELSE
        '0';

    --DECODE e EXECUTE

    opcode <= leitura_de_instrucao(15 DOWNTO 12); -- 4-bit MSB com os opcodes

    registrador_instr <= leitura_de_instrucao(2 DOWNTO 0); -- 3-bit LSB

    saida_endereco <= leitura_de_instrucao(9 DOWNTO 0); -- Visualizar entrada

    imm_op <= "0000" & leitura_de_instrucao(11 DOWNTO 0);

    -- Salto Incondicional

    seletor_jump <= '1' WHEN opcode = "0001" ELSE
        '0';

    saida_jump <= saida_endereco WHEN opcode = "0001";

    -- ADD A, reg

    --seletor_ula <= "10" WHEN opcode = "0010";

    --reg1 <= "111" WHEN opcode = "0010"; -- Acumulador

    --sel_k_reg <= '0' WHEN opcode = "0010"; -- Usa o registrador

    --reg2 <= registrador_instr WHEN opcode = "0010"; -- Registrador

    --controle_mov <= '0' WHEN opcode = "0010";

    -- ADD A, imm

    --seletor_ula <= "10" WHEN opcode = "0011";

    --reg1 <= "111" WHEN opcode = "0011"; -- Acumulador

    --sel_k_reg <= '1' WHEN opcode = "0011"; -- Usa imediato

    --valor_imediato_op <= imm_op WHEN opcode = "0011"; -- Saida da ULA

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