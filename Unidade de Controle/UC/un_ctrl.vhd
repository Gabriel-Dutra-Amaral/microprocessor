LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY un_ctrl IS
    PORT (
        entrada_instrucao : IN unsigned(6 DOWNTO 0);
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        jump_ctrl : in std_logic;
        saida : out unsigned(15 downto 0)
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
            endereco_entrada : IN unsigned(6 DOWNTO 0);
            seletor_jump : IN STD_LOGIC;
            rom_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    signal wr_en_0, state : std_logic := '0';
BEGIN
    state_mac: maquina_de_estados port map(
        clk => clk,
        rst => rst,
        estado => state
    );

    pc_rom_0: pc_rom port map(
        clk => clk,
        wr_en => wr_en_0,
        rst => rst,
        endereco_entrada => entrada_instrucao,
        seletor_jump => jump_ctrl,
        rom_out => saida
    );

    wr_en_0 <= '1' when state = '1' else
        '0';

    

END ARCHITECTURE;