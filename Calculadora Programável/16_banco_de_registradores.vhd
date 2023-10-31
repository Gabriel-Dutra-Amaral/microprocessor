LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY banco_de_registradores IS
    PORT (
        seleciona_registrador_1 : IN unsigned(2 DOWNTO 0);
        seleciona_registrador_2 : IN unsigned(2 DOWNTO 0);
        codigo_registrador : IN unsigned(2 DOWNTO 0);
        escreve_saida : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        saida_registrador_1 : OUT unsigned(15 DOWNTO 0);
        saida_registrador_2 : OUT unsigned(15 DOWNTO 0);
        dado_registrador : IN unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_banco_de_registradores OF banco_de_registradores IS

    COMPONENT reg16bits IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            wr_en : IN STD_LOGIC;
            data_in : IN unsigned(15 DOWNTO 0);
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux16bits_8x3x1 IS
        PORT (
            entr0 : IN unsigned(15 DOWNTO 0);
            entr1 : IN unsigned(15 DOWNTO 0);
            entr2 : IN unsigned(15 DOWNTO 0);
            entr3 : IN unsigned(15 DOWNTO 0);
            entr4 : IN unsigned(15 DOWNTO 0);
            entr5 : IN unsigned(15 DOWNTO 0);
            entr6 : IN unsigned(15 DOWNTO 0);
            entr7 : IN unsigned(15 DOWNTO 0);
            sel : IN unsigned(2 DOWNTO 0);
            saida : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT decoder_3x8 IS
        PORT (
            write_register : IN unsigned(2 DOWNTO 0);
            write_enable : STD_LOGIC;
            saida : OUT unsigned(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL wr_en_0 : STD_LOGIC;
    SIGNAL wr_en_1 : STD_LOGIC;
    SIGNAL wr_en_2 : STD_LOGIC;
    SIGNAL wr_en_3 : STD_LOGIC;
    SIGNAL wr_en_4 : STD_LOGIC;
    SIGNAL wr_en_5 : STD_LOGIC;
    SIGNAL wr_en_6 : STD_LOGIC;
    SIGNAL wr_en_7 : STD_LOGIC;

    SIGNAL data_out_0 : unsigned(15 downto 0);
    SIGNAL data_out_1 : unsigned(15 DOWNTO 0);
    SIGNAL data_out_2 : unsigned(15 DOWNTO 0);
    SIGNAL data_out_3 : unsigned(15 DOWNTO 0);
    SIGNAL data_out_4 : unsigned(15 DOWNTO 0);
    SIGNAL data_out_5 : unsigned(15 DOWNTO 0);
    SIGNAL data_out_6 : unsigned(15 DOWNTO 0);
    SIGNAL data_out_7 : unsigned(15 DOWNTO 0);

BEGIN
    reg_0 : reg16bits PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en_0,
        data_in => dado_registrador,
        data_out => data_out_0
    );

    reg_1 : reg16bits PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en_1,
        data_in => dado_registrador,
        data_out => data_out_1
    );

    reg_2 : reg16bits PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en_2,
        data_in => dado_registrador,
        data_out => data_out_2
    );

    reg_3 : reg16bits PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en_3,
        data_in => dado_registrador,
        data_out => data_out_3
    );

    reg_4 : reg16bits PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en_4,
        data_in => dado_registrador,
        data_out => data_out_4
    );

    reg_5 : reg16bits PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en_5,
        data_in => dado_registrador,
        data_out => data_out_5
    );

    reg_6 : reg16bits PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en_6,
        data_in => dado_registrador,
        data_out => data_out_6
    );

    reg_7 : reg16bits PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en_7,
        data_in => dado_registrador,
        data_out => data_out_7
    );

    mux_0 : mux16bits_8x3x1 PORT MAP(
        entr0 => data_out_0,
        entr1 => data_out_1,
        entr2 => data_out_2,
        entr3 => data_out_3,
        entr4 => data_out_4,
        entr5 => data_out_5,
        entr6 => data_out_6,
        entr7 => data_out_7,
        sel => seleciona_registrador_1,
        saida => saida_registrador_1);

    mux_1 : mux16bits_8x3x1 PORT MAP(
        entr0 => data_out_0,
        entr1 => data_out_1,
        entr2 => data_out_2,
        entr3 => data_out_3,
        entr4 => data_out_4,
        entr5 => data_out_5,
        entr6 => data_out_6,
        entr7 => data_out_7,
        sel => seleciona_registrador_2,
        saida => saida_registrador_2);

    decoder : decoder_3x8 PORT MAP(
        write_register => codigo_registrador,
        write_enable => escreve_saida,
        saida(0) => wr_en_0,
        saida(1) => wr_en_1,
        saida(2) => wr_en_2,
        saida(3) => wr_en_3,
        saida(4) => wr_en_4,
        saida(5) => wr_en_5,
        saida(6) => wr_en_6,
        saida(7) => wr_en_7);

END ARCHITECTURE;