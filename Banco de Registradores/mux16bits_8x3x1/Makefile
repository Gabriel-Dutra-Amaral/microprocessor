all:
	ghdl -a mux16bits_8x3x1.vhd
	ghdl -a mux16bits_8x3x1_tb.vhd
	ghdl -e mux16bits_8x3x1_tb
	ghdl -r mux16bits_8x3x1_tb --wave=mux16bits_8x3x1_tb.ghw
	gtkwave mux16bits_8x3x1_tb.ghw
