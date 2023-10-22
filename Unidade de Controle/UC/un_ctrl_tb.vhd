LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY un_ctrl_tb IS
END ENTITY;

ARCHITECTURE a_un_ctrl_tb OF un_ctrl_tb IS

    COMPONENT un_ctrl IS
        PORT (
            entrada_instrucao : IN unsigned(6 DOWNTO 0);
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            jump_ctrl : IN STD_LOGIC;
            saida : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk, wr_en, rst, seletor_jump : STD_LOGIC := '0';
    SIGNAL endereco_entrada : unsigned(6 DOWNTO 0) := "0000000";
    SIGNAL rom_out : unsigned(15 DOWNTO 0) := "0000000000000000";
    CONSTANT period_time : TIME := 100 ns;
    SIGNAL finished : STD_LOGIC := '0';

BEGIN

    utt : un_ctrl PORT MAP(
        entrada_instrucao => endereco_entrada,
        clk => clk,
        rst => rst,
        jump_ctrl => seletor_jump,
        saida => rom_out
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
        WAIT FOR period_time * 128;
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
        WAIT FOR 100 ns;

        endereco_entrada <= "0001100"; -- Pode começar ou do zero ou do endereco_entrada
        seletor_jump <= '0'; -- Se 1 -> endereco_entrada
        WAIT FOR 100 ns;

        seletor_jump <= '1'; -- Coloca endereco_entrada no pc
        WAIT FOR 100 ns;

        seletor_jump <= '0'; -- volta para o somador do pc -> nao pode esquecer
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END ARCHITECTURE;