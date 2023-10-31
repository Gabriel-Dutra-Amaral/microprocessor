all:

	ghdl -a 0_pc.vhd
	ghdl -a 1_somador.vhd
	ghdl -a 2_pc_forward.vhd
	ghdl -a 3_rom.vhd
	ghdl -a 5_maquina_de_estados.vhd
	ghdl -a 6_un_ctrl.vhd
	ghdl -a 7_maior.vhd
	ghdl -a 8_menor.vhd
	ghdl -a 9_soma.vhd
	ghdl -a 10_subtr.vhd
	ghdl -a 11_mux16bits.vhd
	ghdl -a 12_ula.vhd
	ghdl -a 13_reg16bits.vhd
	ghdl -a 14_mux16bits_8x3x1.vhd
	ghdl -a 15_decoder_3x8.vhd
	ghdl -a 16_banco_de_registradores.vhd
	ghdl -a 99_processador.vhd
	ghdl -a 99_processador_tb.vhd
	ghdl -e 99_processador_tb
	ghdl -r 99_processador_tb --wave=99_processador_tb.ghw
	gtkwave 99_processador_tb.ghw

rm:

	*.ghw
	*.cf