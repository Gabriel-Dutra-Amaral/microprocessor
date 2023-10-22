all:

	ghdl -a pc.vhd
	ghdl -a somador.vhd
	ghdl -a pc_forward.vhd
	ghdl -a rom.vhd
	ghdl -a pc_rom.vhd
	ghdl -a maquina_de_estados.vhd
	ghdl -a un_ctrl.vhd
	ghdl -a pc_rom_uc.vhd
	ghdl -a pc_rom_uc_tb.vhd
	ghdl -e pc_rom_uc_tb
	ghdl -r pc_rom_uc_tb --wave=pc_rom_uc_tb.ghw
	gtkwave pc_rom_uc_tb.ghw

rm:

	*.ghw
	*.cf