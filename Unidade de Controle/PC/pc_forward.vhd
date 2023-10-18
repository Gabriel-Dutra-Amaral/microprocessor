LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc_forward IS
    PORT (
        clk : IN STD_LOGIC;
        wr_en : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        data_in : IN unsigned(6 DOWNTO 0);
        data_out : OUT unsigned(6 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_pc_forward OF pc_forward IS
    COMPONENT pc IS
        PORT (
            clk : IN STD_LOGIC;
            wr_en : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            data_in : IN unsigned(6 DOWNTO 0);
            data_out : OUT unsigned(6 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT somador IS
        PORT (
            entrada : IN unsigned(6 DOWNTO 0);
            saida : OUT unsigned(6 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL pc_out : unsigned(6 DOWNTO 0);
    SIGNAL somador_out : unsigned(6 downto 0);

BEGIN

    pc_0 : pc PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        data_in => somador_out,
        data_out => pc_out
    );

    somador_0 : somador PORT MAP(
        entrada => pc_out,
        saida => somador_out
    );

END ARCHITECTURE;