all:

	ghdl -a converte.vhd
	ghdl -a converte_tb.vhd
	ghdl -e converte_tb
	ghdl -r converte_tb --wave=converte_tb.ghw
	gtkwave converte_tb.ghw

rm:

	*.ghw
	*.cf