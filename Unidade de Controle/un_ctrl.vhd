LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY un_ctrl IS
    PORT (
        leitura_de_instrucao : IN unsigned(15 DOWNTO 0);
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        wr_en_pc : OUT STD_LOGIC;
        seletor_jump : OUT STD_LOGIC;
        saida_jump : OUT unsigned(6 DOWNTO 0);
        saida_de_instrucao : OUT unsigned(15 DOWNTO 0)
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

    SIGNAL state : STD_LOGIC := '0';
    SIGNAL opcode : unsigned(7 DOWNTO 0) := "00000000";
    SIGNAL saida_endereco : unsigned(6 DOWNTO 0) := "0000000";

BEGIN

    state_mac : maquina_de_estados PORT MAP(
        clk => clk,
        rst => rst,
        estado => state
    );

    wr_en_pc <= '1' WHEN state = '1' ELSE
        '0';

    saida_de_instrucao <= leitura_de_instrucao WHEN state = '0' ELSE
        "0000000000000000";

    opcode <= leitura_de_instrucao(15 DOWNTO 8);
    saida_endereco <= leitura_de_instrucao(6 DOWNTO 0);

    seletor_jump <= '1' WHEN opcode = "11111100" ELSE
        '0';

    saida_jump <= saida_endereco WHEN opcode = "11111100" ELSE
        "0000000";

END ARCHITECTURE;