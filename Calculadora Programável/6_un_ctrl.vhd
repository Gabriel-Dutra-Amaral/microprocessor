LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY un_ctrl IS
    PORT (
        leitura_de_instrucao : IN unsigned(15 DOWNTO 0);
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        wr_en_pc : OUT STD_LOGIC;
        wr_reg : OUT STD_LOGIC;
        seletor_jump : OUT STD_LOGIC;
        saida_jump : OUT unsigned(9 DOWNTO 0);
        saida_de_instrucao : OUT unsigned(15 DOWNTO 0);
        sel_mux_ula : OUT STD_LOGIC;
        sel_op_ula : OUT unsigned(1 DOWNTO 0);
        select_reg1_banco : OUT unsigned(2 DOWNTO 0);
        select_reg2_banco : OUT unsigned(2 DOWNTO 0);
        valor_imediato_op : OUT unsigned(15 DOWNTO 0);
        controle_mov : OUT STD_LOGIC
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

    COMPONENT banco_de_registradores is
        PORT (
        read_reg1 : IN unsigned(2 DOWNTO 0);
        read_reg2 : IN unsigned(2 DOWNTO 0);
        write_reg : IN unsigned(2 DOWNTO 0);
        reg_write : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        read_data1 : OUT unsigned(15 DOWNTO 0);
        read_data2 : OUT unsigned(15 DOWNTO 0);
        write_data : IN unsigned(15 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT ula is
        PORT (
        entrada_0, entrada_1 : IN unsigned(15 DOWNTO 0);
        seletor_op : IN unsigned(1 DOWNTO 0);
        saida_ula : OUT unsigned(15 DOWNTO 0)
    );
    END COMPONENT;

    SIGNAL state, write_reg, sel_k_reg : STD_LOGIC := '0';
    SIGNAL opcode : unsigned(3 DOWNTO 0) := "0000";
    SIGNAL saida_endereco : unsigned(9 DOWNTO 0) := "0000000000";
    SIGNAL registrador_instr, reg1, reg2 : unsigned(2 downto 0) := "000";
    SIGNAL imm_op : unsigned(15 downto 0) := "0000000000000000";
    SIGNAL data1, mux_2x1_banco, mux_2x1_ula, data2, ula_out : unsigned(15 downto 0) :="0000000000000000";
    SIGNAL seletor_ula : unsigned(1 downto 0);

BEGIN

    state_mac : maquina_de_estados PORT MAP(
        clk => clk,
        rst => rst,
        estado => state
    );

    banco_0 : banco_de_registradores PORT MAP(
        
        read_reg1 => reg1,
        read_reg2 => reg2,
        write_reg => registrador_instr,
        reg_write => write_reg,
        clk => clk,
        rst => rst,
        read_data1 => data1,
        read_data2 => data2,
        write_data => mux_2x1_banco
    );

    ula_o : ula PORT MAP(
        entrada_0 => data1,
        entrada_1 => mux_2x1_ula,
        saida_ula => ula_out,
        seletor_op => seletor_ula
    );

    mux_2x1_banco <= ula_out WHEN sel_k_reg = '0' else
        imm_op;
    
    mux_2x1_ula <= data2 WHEN sel_k_reg = '0' else
    imm_op;

    --FETCH
    wr_en_pc <= '1' WHEN state = '1' ELSE
        '0';

    --DECODE e EXECUTE
    saida_de_instrucao <= leitura_de_instrucao;
    opcode <= leitura_de_instrucao(15 DOWNTO 12); -- 4-bit MSB com os opcodes
    registrador_instr <= leitura_de_instrucao(2 DOWNTO 0); -- 3-bit LSB
    saida_endereco <= leitura_de_instrucao(9 DOWNTO 0); -- Visualizar entrada
    imm_op <= "0000" & leitura_de_instrucao(11 DOWNTO 0);

    -- Salto Incondicional

    seletor_jump <= '1' WHEN opcode = "0001" ELSE
        '0';

    saida_jump <= saida_endereco WHEN opcode = "0001";

    -- ADD A, reg

    seletor_ula <= "10" WHEN opcode = "0010";

    reg1 <= "111" WHEN opcode = "0010"; -- Acumulador

    sel_k_reg <= '0' WHEN opcode = "0010"; -- Usa o registrador

    reg2 <= registrador_instr WHEN opcode = "0010"; -- Registrador

    controle_mov <= '0' WHEN opcode = "0010";

    -- ADD A, imm

    seletor_ula <= "10" WHEN opcode = "0011";

    reg1 <= "111" WHEN opcode = "0011"; -- Acumulador

    sel_k_reg <= '1' WHEN opcode = "0011"; -- Usa imediato

    valor_imediato_op <= imm_op WHEN opcode = "0011"; -- Saida da ULA

    controle_mov <= '0' WHEN opcode = "0011";

    -- SUB A, reg

    seletor_ula <= "11" WHEN opcode = "0100";

    reg1 <= "111" WHEN opcode = "0100"; -- Acumulador

    sel_k_reg <= '0' WHEN opcode = "0100"; -- Usa o registrador

    reg2 <= registrador_instr WHEN opcode = "0100"; -- Registrador

    controle_mov <= '0' WHEN opcode = "0100";

    -- SUB A, imm

    seletor_ula <= "11" WHEN opcode = "0101";

    reg1 <= "111" WHEN opcode = "0101"; -- Acumulador

    sel_k_reg <= '1' WHEN opcode = "0101"; -- Usa o imediato

    valor_imediato_op <= imm_op WHEN opcode = "0101"; -- Saida da ULA

    controle_mov <= '0' WHEN opcode = "0101";

    -- MOV dst,src

    reg1 <= leitura_de_instrucao(2 DOWNTO 0) WHEN opcode = "1000";

    reg2 <= leitura_de_instrucao(5 DOWNTO 3) WHEN opcode = "1000";

    controle_mov <= '1' WHEN opcode = "1000";

    -- Selecao do registrador a ser escrito no banco

    select_reg1_banco <= reg1;
    select_reg2_banco <= reg2;
    
    --operacao da ula
    sel_op_ula <= seletor_ula;
    
    --constante ou registrador
    sel_mux_ula <= sel_k_reg;

    wr_reg <= write_reg;

END ARCHITECTURE;