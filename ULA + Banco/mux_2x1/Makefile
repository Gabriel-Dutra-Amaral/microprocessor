all:
	ghdl -a mux_2x1.vhd
	ghdl -a mux_2x1_tb.vhd
	ghdl -e mux_2x1_tb
	ghdl -r mux_2x1_tb --wave=mux_2x1_tb.ghw
	gtkwave mux_2x1_tb.ghw
