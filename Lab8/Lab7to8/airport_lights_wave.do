onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /airport_lights_testbench/dut/clk
add wave -noupdate /airport_lights_testbench/dut/reset
add wave -noupdate -divider {Non-Constant Values}
add wave -noupdate /airport_lights_testbench/dut/inputs
add wave -noupdate /airport_lights_testbench/dut/LEDR
add wave -noupdate -divider States
add wave -noupdate /airport_lights_testbench/dut/ps
add wave -noupdate /airport_lights_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {113 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
