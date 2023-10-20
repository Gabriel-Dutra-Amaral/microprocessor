LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc_forward_tb IS
END ENTITY;

ARCHITECTURE a_pc_forward_tb OF pc_forward_tb IS
    COMPONENT pc_forward IS
        PORT (
            clk : IN STD_LOGIC;
            wr_en : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            jump_ctrl : IN STD_LOGIC;
            data_in : IN unsigned(6 DOWNTO 0);
            data_out : OUT unsigned(6 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk, wr_en, rst, jump_ctrl : STD_LOGIC := '0';
    SIGNAL data_in : unsigned(6 DOWNTO 0) := "0000000";
    SIGNAL data_out : unsigned(6 DOWNTO 0) := "0000000";
    CONSTANT period_time : TIME := 100 ns;
    SIGNAL finished : STD_LOGIC := '0';

BEGIN

    utt : pc_forward PORT MAP(
        clk => clk,
        wr_en => wr_en,
        rst => rst,
        jump_ctrl => jump_ctrl,
        data_in => data_in,
        data_out => data_out
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

        data_in <= "0001111";
        jump_ctrl <= '0';
        wr_en <= '1';
        WAIT FOR 300 ns;

        jump_ctrl <= '1';
        WAIT FOR 100 ns;

        jump_ctrl <= '0';
        WAIT;
    END PROCESS;

END ARCHITECTURE;