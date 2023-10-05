LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux16bits_8x3x1_tb IS
END ENTITY;

ARCHITECTURE a_mux16bits_8x3x1_tb OF mux16bits_8x3x1_tb IS
        COMPONENT mux16bits_8x3x1 IS
                PORT (
                        entr0 : IN unsigned(15 DOWNTO 0);
                        entr1 : IN unsigned(15 DOWNTO 0);
                        entr2 : IN unsigned(15 DOWNTO 0);
                        entr3 : IN unsigned(15 DOWNTO 0);
                        entr4 : IN unsigned(15 DOWNTO 0);
                        entr5 : IN unsigned(15 DOWNTO 0);
                        entr6 : IN unsigned(15 DOWNTO 0);
                        entr7 : IN unsigned(15 DOWNTO 0);
                        sel : IN unsigned(2 DOWNTO 0);
                        saida : OUT unsigned(15 DOWNTO 0)
                );
        END COMPONENT;

        SIGNAL entr0,entr1,entr2,entr3,entr4,entr5,entr6,entr7 : unsigned(15 DOWNTO 0) := "0000000000000000";
        SIGNAL sel : unsigned(2 DOWNTO 0);

BEGIN
        utt: mux16bits_8x3x1 PORT MAP(
                entr0 => entr0,
                entr1 => entr1,
                entr2 => entr2,
                entr3 => entr3,
                entr4 => entr4,
                entr5 => entr5,
                entr6 => entr6,
                entr7 => entr7,
                sel => sel
        );

        PROCESS
        BEGIN
                entr0 <= "0000000000000001";
                sel <= "000";
                WAIT FOR 50 ns;
                entr1 <= "0000000000000010";
                sel <= "001";
                WAIT FOR 50 ns;
                entr2 <= "0000000000000011";
                sel <= "010";
                WAIT FOR 50 ns;
                entr3 <= "0000000000000100";
                sel <= "011";
                WAIT FOR 50 ns;
                entr4 <= "0000000000000101";
                sel <= "100";
                WAIT FOR 50 ns;
                entr5 <= "0000000000000110";
                sel <= "101";
                WAIT FOR 50 ns;
                entr6 <= "0000000000000111";
                sel <= "110";
                WAIT FOR 50 ns;
                entr7 <= "0000000000001000";
                sel <= "111";
                WAIT FOR 50 ns;
                WAIT;
        END PROCESS;
END ARCHITECTURE;