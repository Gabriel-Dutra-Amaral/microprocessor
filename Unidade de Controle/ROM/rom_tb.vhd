LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom_tb IS
END ENTITY;

ARCHITECTURE a_rom_tb OF rom_tb IS
    COMPONENT rom IS
        PORT (
            clk : IN STD_LOGIC;
            endereco : IN unsigned(6 DOWNTO 0);
            dado : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL dado : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL endereco : unsigned(6 DOWNTO 0) := "0000000";
    SIGNAL clk,rst : STD_LOGIC := '0';
    CONSTANT period_time : TIME := 100 ns;
    SIGNAL finished : STD_LOGIC := '0';

BEGIN
    utt : rom PORT MAP
    (
        clk => clk,
        endereco => endereco,
        dado => dado
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
        WAIT FOR 100 ns; -- reset

        endereco <= "0000000";
        WAIT FOR 100 ns;

        endereco <= "1111111";
        WAIT FOR 100 ns;

        endereco <= "0001010";
        WAIT FOR 100 ns;
        WAIT;
    END PROCESS;

END ARCHITECTURE;