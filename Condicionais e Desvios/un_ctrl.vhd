LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY un_ctrl IS
    PORT (
        leitura_de_instrucao : IN unsigned(15 DOWNTO 0);
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;

        wr_en_pc : OUT STD_LOGIC;
        seletor_jump : OUT STD_LOGIC; -- Incond
        saida_jump : OUT unsigned(6 DOWNTO 0); -- Incond

        saida_jrult : OUT unsigned(6 DOWNTO 0); -- Cond BLT
        seletor_jrult : OUT STD_LOGIC; -- Cond BLT
        soma_ou_sub_jrult : OUT STD_LOGIC; -- Cond BLT

        reg1 : OUT unsigned(2 DOWNTO 0);
        reg2 : OUT unsigned(2 DOWNTO 0);
        wr_result_en : OUT STD_LOGIC;
        register_code : OUT unsigned(2 DOWNTO 0);

        valor_imediato_op : OUT unsigned(15 DOWNTO 0);
        seletor_ula : OUT unsigned(2 DOWNTO 0);
        imediato_op : OUT STD_LOGIC;

        flag_Carry_o : IN STD_LOGIC;

        saida_estado : OUT unsigned(1 DOWNTO 0)
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

    COMPONENT reg1bit IS
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			wr_en : IN STD_LOGIC;
			data_out : OUT STD_LOGIC;
			data_in : IN STD_LOGIC
		);
	END COMPONENT;

    -- Unidade de Controle --
    SIGNAL estado_maq : unsigned(1 DOWNTO 0) := "00";
    SIGNAL imm_op : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL opcode : unsigned(3 DOWNTO 0) := "0000";
    SIGNAL entrada_uc : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL wr_flag : STD_LOGIC := '0';
    SIGNAL flag_reg_C : STD_LOGIC := '0';


    -- Banco de Registradores --
    SIGNAL registrador_src : unsigned(2 DOWNTO 0) := "000";
    SIGNAL registrador_dst : unsigned(5 DOWNTO 3) := "000";

BEGIN

    state_mac : maquina_de_estados PORT MAP(
        clk => clk,
        rst => rst,
        estado => estado_maq
    );

    reg_flag_c_0 : reg1bit PORT MAP(
		clk => clk,
		rst => rst,
		wr_en => wr_flag,
		data_out => flag_reg_C,
		data_in => flag_Carry_o
	);

    --FETCH
    wr_en_pc <= '0' WHEN estado_maq = "00" ELSE
        '0' WHEN estado_maq = "01" ELSE
        '1' WHEN estado_maq = "10" ELSE
        '0';

    --DECODE
    entrada_uc <= leitura_de_instrucao;
    opcode <= entrada_uc(15 DOWNTO 12);
    imediato_op <= entrada_uc(11);
    imm_op <= "00000000000" & entrada_uc(10 DOWNTO 6) WHEN opcode = "0101" ELSE
        "00000000" & entrada_uc(10 DOWNTO 3);
    valor_imediato_op <= imm_op;
    registrador_dst <= entrada_uc(5 DOWNTO 3);
    registrador_src <= entrada_uc(2 DOWNTO 0);
    reg2 <= registrador_src;
    reg1 <= registrador_dst  WHEN opcode = "0101" else
        "111";
    saida_jump <= (entrada_uc(6 DOWNTO 0));
    saida_jrult <= (entrada_uc(6 DOWNTO 0));
    soma_ou_sub_jrult <= entrada_uc(11);
    register_code <= registrador_dst  WHEN opcode = "0101" else
        "111";

    
    seletor_ula <= "010" WHEN opcode  = "0011"  else --ADD
        "011" WHEN opcode = "0100"  else            --SUB
        "100" WHEN opcode = "0101"  else            --MOV
        "001" WHEN opcode = "0110"  else            --CP
        "000";

    wr_flag <= '1' WHEN opcode = "0110" else
        '0';

    -- JUMP Incondicional
    seletor_jump <= '1' WHEN opcode = "0010"  AND flag_reg_C = '1' else
       '0';
    
    -- JRULT
    seletor_jrult <= '1' WHEN opcode = "0111" else
        '0';

    -- EXECUTE
	wr_result_en <= '1' WHEN estado_maq = "10" AND (opcode = "0101" OR opcode = "0011" OR opcode = "0100" OR opcode = "0001") ELSE
    '0';

    saida_estado <= estado_maq;

END ARCHITECTURE;