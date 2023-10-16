LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY  maquina_de_estados_tb is
END ENTITY;

ARCHITECTURE a_maquina_de_estados_tb OF maquina_de_estados_tb IS
    component maquina_de_estados is          
        PORT(
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        estado: OUT STD_LOGIC
        );
    end component;
                                
    constant period_time : time      := 100 ns; 
    signal   finished    : std_logic := '0';
    signal   clk, rst, estado : std_logic := '0';

begin
    uut: maquina_de_estados port map (
        clk => clk,
        rst =>  rst,
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
        
        WAIT;
    END PROCESS;
end architecture a_maquina_de_estados_tb;
