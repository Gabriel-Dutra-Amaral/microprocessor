all:

	ghdl -a pc.vhd
	ghdl -a somador.vhd
	ghdl -a pc_forward.vhd
	ghdl -a pc_forward_tb.vhd
	ghdl -e pc_forward_tb
	ghdl -r pc_forward_tb --wave=pc_forward_tb.ghw
	gtkwave pc_forward_tb.ghw

rm:

	*.ghw
	*.cf