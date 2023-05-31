

run: compile load

# Create lib
lib:
	vlib MyWork

# Compile source code
# @iverilog -o RegFile RegFile.v
compile:
	
	@vlog -work MyWork -sv tb.sv -l vlog.log 
# Load the design into simulation
load:
	@vsim -c -novopt MyWork.tb -l vsim.log 

# Create waveform
wave: 
	gtkwave tb.vcd

