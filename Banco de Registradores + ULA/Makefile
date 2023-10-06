all:
	ghdl -a maior.vhd
	ghdl -a menor.vhd
	ghdl -a mux16bits.vhd
	ghdl -a soma.vhd
	ghdl -a subtr.vhd
	ghdl -a ula.vhd
	ghdl -a reg16bits.vhd
	ghdl -a mux16bits_8x3x1.vhd
	ghdl -a decoder_3x8.vhd
	ghdl -a banco_de_registradores.vhd
	ghdl -a mux_2x1.vhd
	ghdl -a ula_e_banco.vhd
	ghdl -a ula_e_banco_tb.vhd
	ghdl -e ula_e_banco_tb
	ghdl -r ula_e_banco_tb --wave=ula_e_banco_tb.ghw
	gtkwave ula_e_banco_tb.ghw