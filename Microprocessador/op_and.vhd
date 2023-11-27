LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY op_and IS
    PORT (
        x, y : IN unsigned(15 DOWNTO 0);
        and_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_op_end OF op_and IS
BEGIN
    and_out <= "000000000000000" & (x(0) AND y(0));
END ARCHITECTURE;