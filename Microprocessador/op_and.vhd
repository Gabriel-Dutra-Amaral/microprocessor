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
    SIGNAL x_0 : STD_LOGIC := '0';
    SIGNAL y_0 : STD_LOGIC := '0';
    SIGNAL and_x_y : STD_LOGIC := '0';
BEGIN
    x_0 <= x(0);
    y_0 <= y(0);
    and_x_y <= x_0 AND y_0;
    and_out <= "000000000000000" & and_x_y;
END ARCHITECTURE;