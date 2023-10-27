LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY processador IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        estado : OUT unsigned(1 downto 0);
        pc : OUT unsigned(9 downto 0);
        registrador_de_instrucao :OUT unsigned(15 downto 0);
        saida_banco_reg1 : OUT unsigned(15 downto 0);
        saida_banco_reg2 : OUT unsigned(15 downto 0);
        saida_ula : OUT unsigned(15 downto 0)
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
            entrada_rom : IN unsigned(9 DOWNTO 0);
            saida_rom_dado : OUT unsigned(15 DOWNTO 0)
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
            saida_de_instrucao : OUT unsigned(15 DOWNTO 0);
            sel_mux_ula : OUT STD_LOGIC;
            sel_op_ula : OUT unsigned(1 DOWNTO 0);
            select_reg1_banco : OUT unsigned(2 DOWNTO 0);
            select_reg2_banco : OUT unsigned(2 DOWNTO 0);
            valor_imediato_op : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT banco_de_registradores IS
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

    COMPONENT ula IS
        PORT (
            entrada_0 : IN unsigned(15 DOWNTO 0);
            entrada_1 : IN unsigned(15 DOWNTO 0);
            seletor_op : IN unsigned(1 DOWNTO 0);
            saida_ula : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC; -- clk global
    SIGNAL rst : STD_LOGIC; -- rst global
    SIGNAL wr_en_pc : STD_LOGIC; -- entre pc_forward e un_ctrl
    SIGNAL controle_de_salto : STD_LOGIC; -- entre pc_forward e un_ctrl
    SIGNAL entrada_pc_forward : unsigned(9 DOWNTO 0); -- vem da un_ctrl
    SIGNAL saida_pc_forward : unsigned(9 DOWNTO 0); -- vai pra rom
    SIGNAL saida_rom_instrucao : unsigned(15 DOWNTO 0);
    SIGNAL sel_mux_ula : STD_LOGIC;
    SIGNAL sel_op_ula : unsigned(1 DOWNTO 0);
    SIGNAL select_reg1_banco : unsigned(2 DOWNTO 0);
    SIGNAL select_reg2_banco : unsigned(2 DOWNTO 0);
    SIGNAL valor_imediato_op : unsigned(15 DOWNTO 0);
    SIGNAL saida_reg1_banco : unsigned(15 DOWNTO 0);
    SIGNAL saida_reg2_banco : unsigned(15 DOWNTO 0);
    SIGNAL mux_ula_reg_imm : unsigned(15 downto 0);
    SIGNAL saida_ula : unsigned(15 downto 0);

BEGIN

    pc_forward_0 : pc_forward PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en_pc,
        controle_de_salto => controle_de_salto,
        entrada_pc_forward => entrada_pc_forward,
        saida_pc_forward => saida_pc_forward
    );

    rom_0 : rom PORT MAP(
        clk => clk,
        entrada_rom => saida_pc_forward,
        saida_rom_dado => saida_rom_instrucao
    );

    un_ctrl_0 : un_ctrl PORT MAP(
        leitura_de_instrucao => saida_rom_instrucao, -- vem da ROM
        clk => clk, -- CLK geral
        rst => rst, -- RST geral
        wr_en_pc => wr_en_pc, -- JP
        seletor_jump => controle_de_salto, -- JP
        saida_jump => entrada_pc_forward, -- JP
        saida_de_instrucao => saida_rom_instrucao, -- Fins de visualizacao
        sel_mux_ula => sel_mux_ula, -- reg ou imm
        sel_op_ula => sel_op_ula, -- maior,menor,soma,sub
        select_reg1_banco => select_reg1_banco, -- acumulador
        select_reg2_banco => select_reg2_banco, -- registrador escolhido
        valor_imediato_op => valor_imediato_op -- vai para o mux da ula, entrada 1 dela
    );

    banco_de_registradores_0 : banco_de_registradores PORT MAP(
        read_reg1 => select_reg1_banco,
        read_reg2 => select_reg2_banco,
        write_reg => , -- seleciona o registrador que vai receber o resultado
        reg_write => , -- habilita escrita dentro do banco
        clk => clk,
        rst => rst,
        read_data1 => saida_reg1_banco,
        read_data2 => saida_reg2_banco,
        write_data => saida_ula -- dados que serao escritos no registrador marcado acima
    );

    ula_0 : ula PORT MAP(
        entrada_0 => saida_reg1_banco,
        entrada_1 => mux_ula_reg_imm,
        seletor_op => sel_op_ula,
        saida_ula => saida_ula
    );

    mux_ula_reg_imm <= saida_reg2_banco WHEN sel_mux_ula = '0' ELSE
        valor_imediato_op;

END ARCHITECTURE a_processador;