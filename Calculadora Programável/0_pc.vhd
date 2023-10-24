LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        wr_en : IN STD_LOGIC;
        endereco_entrada_pc : IN unsigned(9 DOWNTO 0);
        endereco_saida_pc : OUT unsigned(9 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_pc OF pc IS

    SIGNAL registro : unsigned(9 DOWNTO 0);

BEGIN
    PROCESS (clk, rst, wr_en)
    BEGIN
        IF rst = '1' THEN
            registro <= "1111111111";
        ELSIF wr_en = '1' THEN
            IF rising_edge(clk) THEN
                registro <= endereco_entrada_pc;
            END IF;
        END IF;
    END PROCESS;

    endereco_saida_pc <= registro;

END ARCHITECTURE;