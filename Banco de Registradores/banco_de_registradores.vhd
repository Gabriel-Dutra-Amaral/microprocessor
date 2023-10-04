LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY banco_de_registradores IS
    PORT (
        read_reg1 : IN unsigned(3 DOWNTO 0);
        //Read REGISTER 1
        read_reg2 : IN unsigned(3 DOWNTO 0);
        //Read REGISTER 2
        write_reg : IN unsigned(3 DOWNTO 0);
        //Write REGISTER
        wr_en : IN STD_LOGIC;
        //RegWrite
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        out_reg1 : OUT unsigned(15 DOWNTO 0);
        out_reg2 : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_banco_de_registradores OF banco_de_registradores IS
    COMPONENT reg16bits IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            wr_en : IN STD_LOGIC;
            data_in : IN unsigned(15 DOWNTO 0);
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux16bits IS
        PORT (
            entr0 : IN unsigned(15 DOWNTO 0);
            entr1 : IN unsigned(15 DOWNTO 0);
            entr2 : IN unsigned(15 DOWNTO 0);
            entr3 : IN unsigned(15 DOWNTO 0);
            sel : IN unsigned(1 DOWNTO 0);
            saida : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ula IS
        PORT (
            entrada_0, entrada_1 : IN unsigned(15 DOWNTO 0);
            seletor_op : IN unsigned(1 DOWNTO 0);
            saida_ula : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    BEGIN
        reg_0: reg16bits PORT MAP();
        reg_1: reg16bits PORT MAP();
        reg_2: reg16bits PORT MAP();
        reg_3: reg16bits PORT MAP();
        reg_4: reg16bits PORT MAP();
        reg_5: reg16bits PORT MAP();
        reg_6: reg16bits PORT MAP();
        reg_7: reg16bits PORT MAP();

    COMPONENT
    END ARCHITECTURE;