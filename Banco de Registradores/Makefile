all:
	ghdl -a reg16bits.vhd
	ghdl -a mux16bits_8x3x1.vhd
	ghdl -a decoder_3x8.vhd
	ghdl -a banco_de_registradores.vhd
	ghdl -a banco_de_registradores_tb.vhd
	ghdl -e banco_de_registradores_tb
	ghdl -r banco_de_registradores_tb --wave=banco_de_registradores_tb.ghw
	gtkwave banco_de_registradores_tb.ghw