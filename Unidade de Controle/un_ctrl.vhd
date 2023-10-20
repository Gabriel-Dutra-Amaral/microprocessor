LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY un_ctrl IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        rom_in : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_un_ctrl OF un_ctrl IS

    COMPONENT pc_rom IS
        PORT (
            clk : IN STD_LOGIC;
            wr_en : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            rom_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT maquina_de_estados IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            estado : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL maquina_out : STD_LOGIC;

BEGIN

    pc_rom_0 : pc_rom PORT MAP(
        clk => clk,
        wr_en => maquina_out,
        rst => rst,
        rom_out => rom_in
    );

    maquina_de_estados_0 : maquina_de_estados PORT MAP(
        clk => clk,
        rst => rst,
        estado => maquina_out
    );

END ARCHITECTURE a_un_ctrl;