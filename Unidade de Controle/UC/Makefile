all:

	ghdl -a pc.vhd
	ghdl -a somador.vhd
	ghdl -a pc_forward.vhd
	ghdl -a rom.vhd
	ghdl -a pc_rom.vhd
	ghdl -a maquina_de_estados.vhd
	ghdl -a un_ctrl.vhd
	ghdl -a un_ctrl_tb.vhd
	ghdl -e un_ctrl_tb
	ghdl -r un_ctrl_tb --wave=un_ctrl_tb.ghw
	gtkwave un_ctrl_tb.ghw

rm:

	*.ghw
	*.cf