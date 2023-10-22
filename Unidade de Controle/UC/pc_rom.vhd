LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc_rom IS
    PORT (
        clk : IN STD_LOGIC;
        wr_en : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        endereco_entrada : IN unsigned(6 DOWNTO 0);
        seletor_jump : IN STD_LOGIC;
        rom_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_pc_rom OF pc_rom IS

    COMPONENT pc_forward IS
        PORT (
            clk : IN STD_LOGIC;
            wr_en : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            jump_ctrl : IN STD_LOGIC;
            data_in : IN unsigned(6 DOWNTO 0);
            data_out : OUT unsigned(6 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT rom IS
        PORT (
            clk : IN STD_LOGIC;
            endereco : IN unsigned(6 DOWNTO 0);
            dado : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL data_between : unsigned(6 DOWNTO 0);

BEGIN

    pc_forward_0 : pc_forward PORT MAP(
        clk => clk,
        wr_en => wr_en,
        rst => rst,
        jump_ctrl => seletor_jump,
        data_in => endereco_entrada,
        data_out => data_between
    );

    rom_0 : rom PORT MAP(
        clk => clk,
        endereco => data_between,
        dado => rom_out
    );

END ARCHITECTURE;