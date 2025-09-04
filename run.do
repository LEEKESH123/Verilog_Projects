vlog fifo_tb.v
vsim tb
add wave -r sim:/tb/dut/*
run -all
