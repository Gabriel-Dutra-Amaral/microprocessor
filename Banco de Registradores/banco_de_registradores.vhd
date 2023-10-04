LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY banco_de_registradores IS
    PORT (
        read_reg1 : IN unsigned(2 DOWNTO 0); //Read_Register_1
        read_reg2 : IN unsigned(2 DOWNTO 0); //Read_Register_2
        write_reg : IN unsigned(2 DOWNTO 0); //Write_Register
        reg_write : IN STD_LOGIC; //RegWrite
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        read_data1 : OUT unsigned(15 DOWNTO 0);
        read_data2 : OUT unsigned(15 DOWNTO 0);
        write_data: IN unsigned(15 DOWNTO 0)
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

    SIGNAL wr_en_0,wr_en_1,wr_en_2,wr_en_3,wr_en_4,wr_en_5,wr_en_6,wr_en_7 : STD_LOGIC;
    SIGNAL data_out_0,data_out_1,data_out_2,data_out_3,data_out_4,data_out_5,data_out_6,data_out_7 : unsigned(15 DOWNTO 0);
    SIGNAL data_zero: unsigned(15 DOWNTO 0) := "0000000000000000";

    BEGIN
        reg_0: reg16bits PORT MAP(clk => clk,rst => rst,wr_en => wr_en_0,data_in => write_data,data_out => data_out_0);
        reg_1: reg16bits PORT MAP(clk => clk,rst => rst,wr_en => wr_en_1,data_in => write_data,data_out => data_out_1);
        reg_2: reg16bits PORT MAP(clk => clk,rst => rst,wr_en => wr_en_2,data_in => write_data,data_out => data_out_2);
        reg_3: reg16bits PORT MAP(clk => clk,rst => rst,wr_en => wr_en_3,data_in => write_data,data_out => data_out_3);
        reg_4: reg16bits PORT MAP(clk => clk,rst => rst,wr_en => wr_en_4,data_in => write_data,data_out => data_out_4);
        reg_5: reg16bits PORT MAP(clk => clk,rst => rst,wr_en => wr_en_5,data_in => write_data,data_out => data_out_5);
        reg_6: reg16bits PORT MAP(clk => clk,rst => rst,wr_en => wr_en_6,data_in => write_data,data_out => data_out_6);
        reg_7: reg16bits PORT MAP(clk => clk,rst => rst,wr_en => wr_en_7,data_in => write_data,data_out => data_out_7);

    END ARCHITECTURE;