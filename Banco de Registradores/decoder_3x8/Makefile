all:
	ghdl -a decoder_3x8.vhd
	ghdl -a decoder_3x8_tb.vhd
	ghdl -e decoder_3x8_tb
	ghdl -r decoder_3x8_tb --wave=decoder_3x8_tb.ghw
	gtkwave decoder_3x8_tb.ghw