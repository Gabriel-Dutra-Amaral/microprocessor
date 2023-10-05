LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY banco_de_registradores_tb IS
END ENTITY;

ARCHITECTURE a_banco_de_registradores_tb OF banco_de_registradores_tb IS
    COMPONENT banco_de_registradores IS
        PORT (
            read_reg1 : IN unsigned(2 DOWNTO 0);
            read_reg2 : IN unsigned(2 DOWNTO 0);
            write_reg : IN unsigned(2 DOWNTO 0);
            reg_write : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            read_data1 : OUT unsigned(15 DOWNTO 0);
            read_data2 : OUT unsigned(15 DOWNTO 0);
            write_data : IN unsigned(15 DOWNTO 0)
        );

        CONSTANT period_time : TIME := 100 ns;
        SIGNAL finished : STD_LOGIC := '0';
        SIGNAL clk, rst, wr_en : STD_LOGIC;
        SIGNAL data_in, data_out : unsigned(15 DOWNTO 0) := "0000000000000000";

        
    END ARCHITECTURE;