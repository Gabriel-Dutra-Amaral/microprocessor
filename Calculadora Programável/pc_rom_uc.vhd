LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc_rom_uc IS
    PORT (
        rst : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        saida_de_instrucao : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_pc_rom_uc OF pc_rom_uc IS

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

    COMPONENT un_ctrl IS
        PORT (
            leitura_de_instrucao : IN unsigned(15 DOWNTO 0);
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            wr_en_pc : OUT STD_LOGIC;
            seletor_jump : OUT STD_LOGIC;
            saida_jump : OUT unsigned(6 DOWNTO 0);
            saida_de_instrucao : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL saida_rom_entrada_uc : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL saida_uc_para_pc_wr_en : STD_LOGIC := '0';
    SIGNAL saida_uc_para_pc_jump_en : STD_LOGIC := '0';
    SIGNAL saida_jump : unsigned(6 DOWNTO 0) := "0000000";
    SIGNAL mux_2x1 : unsigned(6 DOWNTO 0) := "0000000";

BEGIN

    pc_rom_0 : pc_rom PORT MAP(
        clk => clk,
        wr_en => saida_uc_para_pc_wr_en,
        rst => rst,
        endereco_entrada => mux_2x1,
        seletor_jump => saida_uc_para_pc_jump_en,
        rom_out => saida_rom_entrada_uc
    );

    un_ctrl_0 : un_ctrl PORT MAP(
        leitura_de_instrucao => saida_rom_entrada_uc,
        clk => clk,
        rst => rst,
        wr_en_pc => saida_uc_para_pc_wr_en,
        seletor_jump => saida_uc_para_pc_jump_en,
        saida_jump => saida_jump,
        saida_de_instrucao => saida_de_instrucao
    );

    mux_2x1 <= saida_jump WHEN saida_uc_para_pc_jump_en = '1' ELSE
        "0000000";

END ARCHITECTURE;