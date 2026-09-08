onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Nordstrom_testbench/dut/HEX0
add wave -noupdate /Nordstrom_testbench/dut/HEX1
add wave -noupdate /Nordstrom_testbench/dut/HEX2
add wave -noupdate /Nordstrom_testbench/dut/HEX3
add wave -noupdate /Nordstrom_testbench/dut/HEX4
add wave -noupdate /Nordstrom_testbench/dut/HEX5
add wave -noupdate /Nordstrom_testbench/dut/LEDR
add wave -noupdate /Nordstrom_testbench/dut/KEY
add wave -noupdate /Nordstrom_testbench/dut/SW
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {1 ns}
