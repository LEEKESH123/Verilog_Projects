vlog memory_tb.v
vsim tb +test_name=CONSECUTIVE
add wave -r sim:/tb/dut/*
run -all
