LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula_e_banco IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        constante : IN unsigned(15 DOWNTO 0);
        ula_func : IN unsigned(1 DOWNTO 0);
        write_register : IN unsigned(2 DOWNTO 0);
        read_register1 : IN unsigned(2 DOWNTO 0);
        read_register2 : IN unsigned(2 DOWNTO 0);
        ALU_SrcB : IN STD_LOGIC; --determina a segunda entrada da ula
        ula_out : OUT unsigned(15 DOWNTO 0);
        data1 : OUT unsigned(15 DOWNTO 0);
        data2 : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_ula_e_banco OF ula_e_banco IS
    COMPONENT banco_registradores IS
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
            entrada0 : IN unsigned(15 DOWNTO 0);
            entrada1 : IN unsigned(15 DOWNTO 0);
            seletor_op : IN unsigned(1 DOWNTO 0);
            saida_ula : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux_2x1 IS
        PORT (
            sel0 : IN STD_LOGIC;
            entr0, entr1 : IN unsigned(15 DOWNTO 0);
            saida : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL read_data1, saida_mux, mux_entr0, ula_out_internal : unsigned(15 DOWNTO 0);

BEGIN
    ula_0 : ula PORT MAP(
        entrada0 => read_data1,
        entrada1 => saida_mux, --saida do mux na outra entrada da ula
        seletor_op => ula_func,
        saida_ula => ula_out_internal
    );

    banco_reg_0 : banco_registradores PORT MAP(
        clk => clk,
        rst => rst,
        reg_write => enable,
        write_data => ula_out_internal, --saida da ula na entrada de dados do banco
        write_reg => write_register,
        read_reg1 => read_register1,
        read_reg2 => read_register2,
        read_data1 => read_data1, --saida do banco numa das entradas da ula
        read_data2 => mux_entr0 --outra saida do banco num mux
    );

    mux_2x1_0 : mux_2x1 PORT MAP(
        sel0 => ALU_SrcB, entr0 => mux_entr0,
        entr1 => constante, --pino de entrada top level na outra entrada do MUX 
        saida => saida_mux
    );

    data1 <= read_data1;
    data2 <= saida_mux;
    ula_out <= ula_out_internal; --pino de saida extra na saida da ula

END ARCHITECTURE;