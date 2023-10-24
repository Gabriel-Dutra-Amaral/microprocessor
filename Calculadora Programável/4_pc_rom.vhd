LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc_rom IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        wr_en : IN STD_LOGIC;
        endereco_entrada : IN unsigned(9 DOWNTO 0);
        seletor_jump : IN STD_LOGIC;
        saida_rom : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_pc_rom OF pc_rom IS

    COMPONENT pc_forward IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            wr_en : IN STD_LOGIC;
            controle_de_salto : IN STD_LOGIC;
            entrada_pc_forward : IN unsigned(9 DOWNTO 0);
            saida_pc_forward : OUT unsigned(9 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT rom IS
        PORT (
            clk : IN STD_LOGIC;
            entrada_rom : IN unsigned(9 DOWNTO 0);
            saida_rom_dado : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL entrada_rom_entre_pcfw_rom : unsigned(9 DOWNTO 0);

BEGIN

    pc_forward_0 : pc_forward PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        controle_de_salto => seletor_jump,
        entrada_pc_forward => endereco_entrada,
        saida_pc_forward => entrada_rom_entre_pcfw_rom
    );

    rom_0 : rom PORT MAP(
        clk => clk,
        entrada_rom => entrada_rom_entre_pcfw_rom,
        saida_rom_dado => saida_rom
    );

END ARCHITECTURE;