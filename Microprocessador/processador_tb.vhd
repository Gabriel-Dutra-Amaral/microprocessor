LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY processador_tb IS
END ENTITY;

ARCHITECTURE a_processador_tb OF processador_tb IS

    COMPONENT processador IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            estado : OUT unsigned(1 DOWNTO 0);
            pc_saida : OUT unsigned(6 DOWNTO 0);
            registrador_de_instr : OUT unsigned(15 DOWNTO 0);
            saida_banco_reg1 : OUT unsigned(15 DOWNTO 0);
            saida_banco_reg2 : OUT unsigned(15 DOWNTO 0);
            saida_da_ula : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC := '0';
    CONSTANT period_time : TIME := 100 ns;
    SIGNAL finished : STD_LOGIC := '0';
    SIGNAL estado : unsigned(1 DOWNTO 0) := "00";
    SIGNAL pc_saida : unsigned(6 DOWNTO 0) := "0000000";
    SIGNAL registrador_de_instr : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL saida_banco_reg1 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL saida_banco_reg2 : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL saida_da_ula : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN

    utt : processador PORT MAP(
        clk => clk,
        rst => rst,
        estado => estado,
        pc_saida => pc_saida,
        registrador_de_instr => registrador_de_instr,
        saida_banco_reg1 => saida_banco_reg1,
        saida_banco_reg2 => saida_banco_reg2,
        saida_da_ula => saida_da_ula
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
        WAIT FOR period_time * 3000;
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

END ARCHITECTURE a_processador_tb;