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
        saida_jump : OUT unsigned(9 DOWNTO 0);
        saida_de_instrucao : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_un_ctrl OF un_ctrl IS

    COMPONENT maquina_de_estados IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;0000
            estado : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL state : unsigned(1 downto 0) := "00";
    SIGNAL opcode : unsigned(3 DOWNTO 0) := "0000";
    SIGNAL saida_endereco : unsigned(9 DOWNTO 0) := "0000000000";

BEGIN

    state_mac : maquina_de_estados PORT MAP(
        clk => clk,
        rst => rst,
        estado => state
    );

    wr_en_pc <= '1' WHEN state = "10" ELSE
        '0';

    saida_de_instrucao <= leitura_de_instrucao;

    opcode <= leitura_de_instrucao(15 DOWNTO 11); -- 4-bit MSB com os opcodes
    saida_endereco <= leitura_de_instrucao(9 DOWNTO 0); -- Visualizar entrada

    -- Salto Incondicional

    seletor_jump <= '1' WHEN opcode = "0001" ELSE
        '0';

    saida_jump <= saida_endereco WHEN opcode = "11111100" ELSE
        "0000000";

    -- Fim Salto Incondicional

    -- ADD



    -- Fim ADD

    -- SUB



    -- Fim SUB

END ARCHITECTURE;