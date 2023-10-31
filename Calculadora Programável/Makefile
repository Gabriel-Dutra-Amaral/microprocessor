all:

	ghdl -a pc.vhd
	ghdl -a somador.vhd
	ghdl -a pc_forward.vhd
	ghdl -a rom.vhd
	ghdl -a maquina_de_estados.vhd
	ghdl -a un_ctrl.vhd
	ghdl -a maior.vhd
	ghdl -a menor.vhd
	ghdl -a soma.vhd
	ghdl -a subtr.vhd
	ghdl -a mov.vhd
	ghdl -a mux16bits.vhd
	ghdl -a ula.vhd
	ghdl -a reg16bits.vhd
	ghdl -a mux16bits_8x3x1.vhd
	ghdl -a decoder_3x8.vhd
	ghdl -a banco_de_registradores.vhd
	ghdl -a processador.vhd
	ghdl -a processador_tb.vhd
	ghdl -e processador_tb
	ghdl -r processador_tb --wave=processador_tb.ghw
	gtkwave processador_tb.ghw

rm:

	*.ghw
	*.cf