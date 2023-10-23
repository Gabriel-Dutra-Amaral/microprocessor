LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc_rom_uc_tb IS
END ENTITY;

ARCHITECTURE a_pc_rom_uc_tb OF pc_rom_uc_tb IS

    COMPONENT pc_rom_uc IS
        PORT (
            rst : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            saida_de_instrucao : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk, wr_en, rst, seletor_jump : STD_LOGIC := '0';
    SIGNAL saida_de_instrucao : unsigned(15 DOWNTO 0) := "0000000000000000";
    CONSTANT period_time : TIME := 100 ns;
    SIGNAL finished : STD_LOGIC := '0';

BEGIN

    utt : pc_rom_uc PORT MAP(
        rst => rst,
        clk => clk,
        saida_de_instrucao => saida_de_instrucao
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

END ARCHITECTURE;