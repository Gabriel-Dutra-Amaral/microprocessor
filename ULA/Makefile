all:
	ghdl -a maior.vhd
	ghdl -a menor.vhd
	ghdl -a mux16bits.vhd
	ghdl -a soma.vhd
	ghdl -a subtr.vhd
	ghdl -a ula.vhd
	ghdl -a ula_tb.vhd
	ghdl -e ula_tb
	ghdl -r ula_tb --wave=ula_tb.ghw
	gtkwave ula_tb.ghw