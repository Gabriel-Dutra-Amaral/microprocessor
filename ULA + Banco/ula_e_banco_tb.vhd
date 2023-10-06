LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula_e_banco_tb IS
END ENTITY;

ARCHITECTURE a_ula_e_banco_tb OF ula_e_banco_tb IS
    COMPONENT ula_e_banco IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            constante : IN unsigned(15 DOWNTO 0);
            ula_func : IN unsigned(1 DOWNTO 0);
            write_data : IN unsigned(15 DOWNTO 0);
            write_register : IN unsigned(2 DOWNTO 0);
            read_register1 : IN unsigned(2 DOWNTO 0);
            read_register2 : IN unsigned(2 DOWNTO 0);
            ALU_SrcB : IN STD_LOGIC; -- Determina a segunda entrada da ula
            ula_out : OUT unsigned(15 DOWNTO 0);
            data1 : OUT unsigned(15 DOWNTO 0);
            data2 : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    CONSTANT period_time : TIME := 100 ns;
    SIGNAL finished : STD_LOGIC := '0';
    SIGNAL clk, rst, enable, Alu_SrcB : STD_LOGIC := '0';
    SIGNAL read_reg1, read_reg2, write_reg : unsigned(2 DOWNTO 0) := "000";
    SIGNAL sinal_op_ula : unsigned(1 DOWNTO 0) := "00";
    SIGNAL data1, data2, write_data, constante, saida_ula : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN

    utt : ula_e_banco PORT MAP(
        clk => clk,
        rst => rst,
        enable => enable,
        constante => constante,
        ula_func => sinal_op_ula,
        write_data => write_data,
        write_register => write_reg,
        read_register1 => read_reg1,
        read_register2 => read_reg2,
        ALU_SrcB => Alu_SrcB, -- Determina a segunda entrada da ula
        ula_out => saida_ula,
        data1 => data1,
        data2 => data2
    );

    rst_global : PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR period_time;
        rst <= '0';
        WAIT;
    END PROCESS;

    sim_time_proc : PROCESS
    BEGIN
        WAIT FOR period_time * 10;
        finished <= '1';
        WAIT;
    END PROCESS sim_time_proc;

    clk_proc : PROCESS
    BEGIN
        WHILE finished /= '1' LOOP
            clk <= '0';
            WAIT FOR period_time/2;
            clk <= '1';
            WAIT FOR period_time/2;
        END LOOP;
        WAIT;
    END PROCESS clk_proc;

    PROCESS
    BEGIN
        WAIT FOR 100 ns; -- Reset

        enable <= '1';
        write_reg <= "001";
        write_data <= "0000000000000011";
        WAIT FOR 100 ns;

        enable <= '1';
        write_reg <= "010";
        write_data <= "0000000000000111";
        WAIT FOR 100 ns;

        enable <= '0';
        Alu_SrcB <= '0'; -- Registrador
        sinal_op_ula <= "10"; -- Soma
        WAIT FOR 100 ns;

        enable <= '0';
        read_reg1 <= "001";
        read_reg2 <= "010";
        WAIT FOR 100 ns;

        enable <= '1';
        write_reg <= "011";
        write_data <= saida_ula;
        WAIT FOR 100 ns;

        enable <= '0';
        read_reg1 <= "000";
        read_reg2 <= "000";
        WAIT FOR 100 ns;

        enable <= '0';
        read_reg1 <= "011";
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END ARCHITECTURE;