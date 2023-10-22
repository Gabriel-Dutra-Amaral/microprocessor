LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY un_ctrl IS
    PORT (
        entrada_instrucao : IN unsigned(6 DOWNTO 0);
    );
END ENTITY;

ARCHITECTURE a_un_ctrl OF un_ctrl IS

    COMPONENT maquina_de_estados IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            estado : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT pc_rom IS
        PORT (
            clk : IN STD_LOGIC;
            wr_en : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            rom_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    

END ARCHITECTURE;