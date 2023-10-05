LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY banco_de_registradores_tb IS
END ENTITY;

ARCHITECTURE a_banco_de_registradores_tb OF banco_de_registradores_tb IS
    COMPONENT banco_de_registradores IS
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

    CONSTANT period_time : TIME := 100 ns;
    SIGNAL finished : STD_LOGIC := '0';
    SIGNAL clk, rst, reg_write : STD_LOGIC := '0';
    SIGNAL read_reg1, read_reg2, write_reg : unsigned(2 DOWNTO 0) := "000";
    SIGNAL read_data1, read_data2, write_data : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN
    utt : banco_de_registradores PORT MAP(
        read_reg1 => read_reg1,
        read_reg2 => read_reg2,
        write_reg => write_reg,
        reg_write => reg_write,
        clk => clk,
        rst => rst,
        read_data1 => read_data1,
        read_data2 => read_data2,
        write_data => write_data
    );

    rst_global : PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR period_time * 2;
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
        reg_write <= '1';
        write_reg <= "000";
        write_data <= "0000000000001111";
        WAIT FOR 100 ns;
        reg_write <= '0';
        read_reg1 <= "001";
        WAIT FOR 100 ns;
        reg_write <= '0';
        write_reg <= "000";
        write_data <= "0000000000000101";
        WAIT FOR 100 ns;
        WAIT;
    END PROCESS;

END ARCHITECTURE;