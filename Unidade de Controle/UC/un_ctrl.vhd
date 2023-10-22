LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY un_ctrl IS
    PORT (
        entrada_instrucao : IN unsigned(6 DOWNTO 0);
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        jump_ctrl : IN STD_LOGIC;
        saida : OUT unsigned(15 DOWNTO 0)
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

    SIGNAL wr_en_0, state : STD_LOGIC := '0';
    SIGNAL opcode : unsigned(7 DOWNTO 0) := "00000000";
    SIGNAL saida_da_rom : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN

    state_mac : maquina_de_estados PORT MAP(
        clk => clk,
        rst => rst,
        estado => state
    );

    pc_rom_0 : pc_rom PORT MAP(
        clk => clk,
        wr_en => wr_en_0,
        rst => rst,
        endereco_entrada => entrada_instrucao,
        seletor_jump => jump_ctrl,
        rom_out => saida
    );

    wr_en_0 <= '1' WHEN state = '1' ELSE
        '0';

END ARCHITECTURE;