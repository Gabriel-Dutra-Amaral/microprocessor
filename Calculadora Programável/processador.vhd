LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY processador IS
    PORT (

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
            saida_de_instrucao : OUT unsigned(15 DOWNTO 0)
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
            entrada_0, entrada_1 : IN unsigned(15 DOWNTO 0);
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
    SIGNAL saida_rom_instrucao : unsigned(9 DOWNTO 0);

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
        leitura_de_instrucao => saida_rom_instrucao,
        clk => clk,
        rst => rst,
        wr_en_pc => wr_en_pc,
        seletor_jump => controle_de_salto,
        saida_jump => entrada_pc_forward,
        saida_de_instrucao => saida_de_instrucao
    );

    banco_de_registradores_0 : banco_de_registradores PORT MAP(
        read_reg1 => read_data1,
        read_reg2 => read_data2,
        write_reg => write_reg,
        reg_write => reg_write,
        clk => clk,
        rst => rst,
        read_data1 => read_data1,
        read_data2 => read_data2,
        write_data => write_data
    );

    ula_0 : ula PORT MAP(
        entrada_0 => entrada_0_ula
        entrada_1 => entrada_1_ula
        seletor_op => seletor_op_ula
        saida_ula => saida_ula
    );

END ARCHITECTURE a_processador;