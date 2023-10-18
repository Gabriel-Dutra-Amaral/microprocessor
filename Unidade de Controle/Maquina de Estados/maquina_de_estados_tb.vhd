LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY maquina_de_estados_tb IS
END ENTITY;

ARCHITECTURE a_maquina_de_estados_tb OF maquina_de_estados_tb IS
    COMPONENT maquina_de_estados IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            estado : OUT STD_LOGIC
        );
    END COMPONENT;

    CONSTANT period_time : TIME := 100 ns;
    SIGNAL finished : STD_LOGIC := '0';
    SIGNAL clk, rst, estado : STD_LOGIC := '0';

BEGIN
    uut : maquina_de_estados PORT MAP(
        clk => clk,
        rst => rst,
        estado => estado
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
        WAIT FOR period_time * 5;
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

        WAIT;
    END PROCESS;
END ARCHITECTURE a_maquina_de_estados_tb;