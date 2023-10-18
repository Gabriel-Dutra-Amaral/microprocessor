LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc IS
    PORT (
        clk : IN STD_LOGIC;
        wr_en : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        data_in : IN unsigned(6 DOWNTO 0);
        data_out : OUT unsigned(6 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_pc OF pc IS

    SIGNAL registro : unsigned(6 DOWNTO 0);
BEGIN
    PROCESS (clk, rst, wr_en)
    BEGIN
        IF rst = '1' THEN
            registro <= "0000000";
        ELSIF wr_en = '1' THEN
            IF rising_edge(clk) THEN
                registro <= data_in;
            END IF;
        END IF;
    END PROCESS;

    data_out <= registro;

END ARCHITECTURE;