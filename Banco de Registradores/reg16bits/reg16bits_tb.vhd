LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY reg16bits_tb IS
END ENTITY;

ARCHITECTURE a_reg16bits_tb OF reg16bits_tb IS
    COMPONENT reg16bits IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            wr_en : IN STD_LOGIC;
            data_in : IN unsigned(15 DOWNTO 0);
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;
    -- 100ns é o período para o clock
    CONSTANT period_time : TIME := 100 ns;
    SIGNAL finished : STD_LOGIC := '0';
    SIGNAL clk, rst, wr_en : STD_LOGIC;
    SIGNAL data_in, data_out : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN
    utt : reg16bits PORT MAP(
        clk => clk,
        rst => rst,
        data_in => data_in,
        data_out => data_out,
        wr_en => wr_en
    );

    rst_global : PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR period_time*2; --espera 2 clocks
        rst <= '0';
        WAIT;
    END PROCESS;

    sim_time_proc : PROCESS
    BEGIN
        WAIT FOR period_time*10; --tempo total da simulação
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
        wr_en <= '0';
        data_in <= "0000000000001111";
        WAIT FOR 100 ns;
        wr_en <= '1';
        data_in <= "0000000000001010";
        WAIT FOR 100 ns;
        wr_en <= '0';
        data_in <= "0000000000000011";
        WAIT FOR 100 ns;
        wr_en <= '1';
        data_in <= "0000000000000100";
        WAIT;
    END PROCESS;

END ARCHITECTURE;