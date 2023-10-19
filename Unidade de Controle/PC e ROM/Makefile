all:

	ghdl -a pc.vhd
	ghdl -a somador.vhd
	ghdl -a pc_forward.vhd
	ghdl -a rom.vhd
	ghdl -a pc_rom.vhd
	ghdl -a pc_rom_tb.vhd
	ghdl -e pc_rom_tb
	ghdl -r pc_rom_tb --wave=pc_rom_tb.ghw
	gtkwave pc_rom_tb.ghw

rm:

	*.ghw
	*.cf