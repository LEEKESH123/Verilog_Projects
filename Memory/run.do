# Compile DUT and TB
vlog memory.v mem_tb.v  

# Load simulation
vsim tb  

# Add useful signals
add wave -group TB  sim:/tb/*
add wave -group DUT sim:/tb/dut/*

# Run simulation
run -all

