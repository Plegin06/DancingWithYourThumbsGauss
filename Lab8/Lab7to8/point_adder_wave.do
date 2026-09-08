onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /point_adder_testbench/dut/clk
add wave -noupdate /point_adder_testbench/dut/reset
add wave -noupdate /point_adder_testbench/dut/score
add wave -noupdate -radix decimal /point_adder_testbench/dut/total
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {11500 ps} {12500 ps}
