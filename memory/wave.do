onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clk
add wave -noupdate /tb/res
add wave -noupdate /tb/valid
add wave -noupdate /tb/ready
add wave -noupdate -radix unsigned /tb/wr_rd
add wave -noupdate -radix unsigned /tb/addr
add wave -noupdate -radix unsigned /tb/wdata
add wave -noupdate -radix unsigned /tb/rdata
add wave -noupdate /tb/i
add wave -noupdate /tb/j
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {355 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 133
configure wave -valuecolwidth 46
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {206 ps} {505 ps}
