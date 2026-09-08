onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /point_displayer_testbench/dut/in
add wave -noupdate /point_displayer_testbench/dut/HEXSIGN
add wave -noupdate /point_displayer_testbench/dut/HEXHunds
add wave -noupdate /point_displayer_testbench/dut/HEXTens
add wave -noupdate /point_displayer_testbench/dut/HEXOnes
add wave -noupdate /point_displayer_testbench/dut/is_negative
add wave -noupdate /point_displayer_testbench/dut/absolute_value
add wave -noupdate -radix unsigned /point_displayer_testbench/dut/ones
add wave -noupdate -radix unsigned /point_displayer_testbench/dut/tens
add wave -noupdate -radix unsigned /point_displayer_testbench/dut/hundreds
add wave -noupdate /point_displayer_testbench/dut/grouping
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {33 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {250 ps}
