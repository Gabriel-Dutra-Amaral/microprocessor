all:

	ghdl -a maquina_de_estados.vhd
	ghdl -a maquina_de_estados_tb.vhd
	ghdl -e maquina_de_estados_tb
	ghdl -r maquina_de_estados_tb --wave=maquina_de_estados_tb.ghw
	gtkwave maquina_de_estados_tb.ghw

rm:

	*.ghw
	*.cf