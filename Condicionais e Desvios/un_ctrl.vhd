LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY un_ctrl IS
    PORT (
        leitura_de_instrucao : IN unsigned(15 DOWNTO 0);
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;

        wr_en_pc : OUT STD_LOGIC;
        seletor_jump : OUT STD_LOGIC; -- Incond
        saida_jump : OUT unsigned(9 DOWNTO 0); -- Incond

        saida_jrult : OUT unsigned(9 DOWNTO 0); -- Cond BLT
        seletor_jrult : OUT STD_LOGIC; -- Cond BLT

        reg1 : OUT unsigned(2 DOWNTO 0);
        reg2 : OUT unsigned(2 DOWNTO 0);
        wr_result_en : OUT STD_LOGIC;
        register_code : OUT unsigned(2 DOWNTO 0);

        valor_imediato_op : OUT unsigned(15 DOWNTO 0);
        seletor_ula : OUT unsigned(2 DOWNTO 0);
        imediato_op : OUT STD_LOGIC;

        flag_Carry_o : IN STD_LOGIC;

        saida_estado : OUT unsigned(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_un_ctrl OF un_ctrl IS

    COMPONENT maquina_de_estados IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            estado : OUT unsigned(1 DOWNTO 0)
        );
    END COMPONENT;

    -- Unidade de Controle --
    SIGNAL estado_maq : unsigned(1 DOWNTO 0) := "00";
    SIGNAL imm_op : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL opcode : unsigned(3 DOWNTO 0) := "0000";
    SIGNAL entrada_uc : unsigned(15 DOWNTO 0) := "0000000000000000";

    -- Banco de Registradores --
    SIGNAL registrador_src : unsigned(2 DOWNTO 0) := "000";
    SIGNAL registrador_dst : unsigned(5 DOWNTO 3) := "000";

BEGIN

    state_mac : maquina_de_estados PORT MAP(
        clk => clk,
        rst => rst,
        estado => estado_maq
    );

    PROCESS (estado_maq, opcode)
    BEGIN
        CASE estado_maq IS
            WHEN "00" =>
                wr_en_pc <= '0';
                wr_result_en <= '0';
                seletor_jump <= '0';
                entrada_uc <= leitura_de_instrucao;
            WHEN "01" =>
                opcode <= entrada_uc(15 DOWNTO 12);
                registrador_src <= entrada_uc(2 DOWNTO 0);
                registrador_dst <= entrada_uc(5 DOWNTO 3);
                imm_op <= "00000000000" & entrada_uc(10 DOWNTO 6);
            WHEN "10" =>
                wr_en_pc <= '1';
                CASE opcode IS
                    WHEN "0001" =>
                        -- Salto Incondicional --
                        -- B"0001_00_EEEEEEEEEE"
                        -- E: endereço (10-bits)
                        seletor_jump <= '1';
                        saida_jump <= (entrada_uc(9 DOWNTO 0) - 1);
                    WHEN "1000" =>
                        -- MOV reg/imediato --
                        -- B"1000_I_CCCCC_ddd_sss"
                        -- I: 0 se registrador, 1 se imediato (1-bit)
                        -- C: conteúdo (dado de 6-bits)
                        -- d: registrador destino (3-bits)
                        -- s: registrador fonte (3-bits)
                        reg1 <= registrador_dst;
                        reg2 <= registrador_src;
                        imediato_op <= entrada_uc(11);
                        valor_imediato_op <= imm_op;
                        seletor_ula <= "100";
                        wr_result_en <= '1';
                        register_code <= registrador_dst;
                    WHEN "0010" =>
                        -- ADD reg/imediato --
                        -- B"0010_I_CCCCC_ddd_sss"
                        -- I: 0 se registrador, 1 se imediato (1-bit)
                        -- C: conteúdo (dado de 6-bits)
                        -- d: registrador destino (3-bits)
                        -- s: registrador fonte (3-bits)
                        -- ddd+sss OU ddd+imm
                        reg1 <= registrador_dst;
                        reg2 <= registrador_src;
                        imediato_op <= entrada_uc(11);
                        valor_imediato_op <= imm_op;
                        seletor_ula <= "010";
                        wr_result_en <= '1';
                        register_code <= registrador_dst;
                    WHEN "0100" =>
                        -- SUB reg/imediato --
                        -- B"0100_I_CCCCCC_ddd_sss"
                        -- I: 0 se registrador, 1 se imediato (1-bit)
                        -- C: conteúdo (dado de 6-bits)
                        -- d: registrador destino (3-bits)
                        -- s: registrador fonte (3-bits)
                        -- ddd-sss OU ddd-imm
                        reg1 <= registrador_dst;
                        reg2 <= registrador_src;
                        imediato_op <= entrada_uc(11);
                        valor_imediato_op <= imm_op;
                        seletor_ula <= "011";
                        wr_result_en <= '1';
                        register_code <= registrador_dst;
                    WHEN "0110" =>
                        -- CP reg/imediato
                        -- B"0110_I_CCCCC_ddd_sss"
                        -- I: 0 se registrador, 1 se imediato (1-bit)
                        -- C: conteúdo (dado de 6-bits)
                        -- d: registrador_1 (3-bits)
                        -- s: registrador_2 (3-bits)
                        seletor_ula <= "001"; -- operação menor
                        reg1 <= registrador_dst;
                        reg2 <= registrador_src;
                        imediato_op <= entrada_uc(11);
                        valor_imediato_op <= imm_op;
                    WHEN "1001" =>
                        -- JRULT -> PC = PC + X;
                        -- B"1001_YY_XXXXXXXXXX"
                        -- Y: não importa
                        -- X: endereco do branch
                        CASE flag_Carry_o IS
                            WHEN '0' =>
                                seletor_jrult <= '0';
                                saida_jrult <= "0000000000";
                            WHEN '1' =>
                                seletor_jrult <= '1';
                                saida_jrult <= entrada_uc(9 DOWNTO 0);
                            WHEN OTHERS =>
                                seletor_jrult <= '0';
                                saida_jrult <= "0000000000";
                        END CASE;
                    WHEN OTHERS => -- NOP
                        imediato_op <= '0';
                        valor_imediato_op <= "0000000000000000";
                        seletor_ula <= "000";
                        wr_result_en <= '0';
                        register_code <= "000";
                END CASE;
            WHEN OTHERS =>
                wr_en_pc <= '0';
                wr_result_en <= '0';
                seletor_jump <= '0';
        END CASE;
    END PROCESS;

    saida_estado <= estado_maq;

END ARCHITECTURE;