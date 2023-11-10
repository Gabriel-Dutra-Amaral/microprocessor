LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY converte IS
    PORT (
        num_complemento_dois : IN unsigned(9 DOWNTO 0);
        num_normal : OUT unsigned(9 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_converte OF converte IS

BEGIN
    PROCESS (num_complemento_dois)
    BEGIN
        IF num_complemento_dois(9) = '1' THEN
            -- Número negativo (complemento de dois)
            num_normal <= (NOT num_complemento_dois) + 1; -- Inverte os bits e adiciona 1
        ELSE
            -- Número positivo (complemento de dois é igual ao número normal)
            num_normal <= num_complemento_dois;
        END IF;
    END PROCESS;

END ARCHITECTURE;