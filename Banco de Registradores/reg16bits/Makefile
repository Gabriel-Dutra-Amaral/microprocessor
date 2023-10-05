all:
	ghdl -a reg16bits.vhd
	ghdl -a reg16bits_tb.vhd
	ghdl -e reg16bits_tb
	ghdl -r reg16bits_tb --wave=reg16bits_tb.ghw
	gtkwave reg16bits_tb.ghw