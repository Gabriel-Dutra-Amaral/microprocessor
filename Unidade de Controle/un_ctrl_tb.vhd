LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY un_ctrl_tb IS
END ENTITY;

ARCHITECTURE a_un_ctrl_tb OF un_ctrl_tb IS

    COMPONENT un_ctrl IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            rom_in : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk, wr_en, rst : STD_LOGIC := '0';
    SIGNAL rom_in : unsigned(15 DOWNTO 0) := "0000000000000000";
    CONSTANT period_time : TIME := 100 ns;
    SIGNAL finished : STD_LOGIC := '0';

BEGIN

    utt : un_ctrl PORT MAP(
        clk => clk,
        rst => rst,
        rom_in => rom_in
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
    
END ARCHITECTURE a_un_ctrl_tb;