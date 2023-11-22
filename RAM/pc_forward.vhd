LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc_forward IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        wr_en : IN STD_LOGIC;
        controle_de_salto : IN STD_LOGIC;
        entrada_pc_forward : IN unsigned(6 DOWNTO 0);
        saida_pc_forward : OUT unsigned(6 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_pc_forward OF pc_forward IS

    COMPONENT pc IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            wr_en : IN STD_LOGIC;
            endereco_entrada_pc : IN unsigned(6 DOWNTO 0);
            endereco_saida_pc : OUT unsigned(6 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT somador IS
        PORT (
            entrada_somador : IN unsigned(6 DOWNTO 0);
            saida_somador : OUT unsigned(6 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL saida_pc_entrada_somador : unsigned(6 DOWNTO 0) := "0000000";
    SIGNAL saida_somador : unsigned(6 DOWNTO 0) := "0000000";
    SIGNAL mux_2x1_salto_ou_somador : unsigned(6 DOWNTO 0) := "0000000";

BEGIN

    pc_0 : pc PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        endereco_entrada_pc => mux_2x1_salto_ou_somador,
        endereco_saida_pc => saida_pc_entrada_somador
    );

    somador_0 : somador PORT MAP(
        entrada_somador => saida_pc_entrada_somador,
        saida_somador => saida_somador
    );

    mux_2x1_salto_ou_somador <= entrada_pc_forward WHEN controle_de_salto = '1' ELSE
        saida_somador;

    saida_pc_forward <= saida_somador;

END ARCHITECTURE;