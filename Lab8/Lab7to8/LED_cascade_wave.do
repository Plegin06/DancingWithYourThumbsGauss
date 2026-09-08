onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /LED_cascade_testbench/dut/reset
add wave -noupdate /LED_cascade_testbench/dut/clk
add wave -noupdate /LED_cascade_testbench/dut/enable
add wave -noupdate -expand /LED_cascade_testbench/dut/column
add wave -noupdate /LED_cascade_testbench/dut/current_row
add wave -noupdate /LED_cascade_testbench/dut/pulse_in
add wave -noupdate /LED_cascade_testbench/pulse
add wave -noupdate /LED_cascade_testbench/dut/pixels_col
add wave -noupdate /LED_cascade_testbench/dut/pulse
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {580 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 113
configure wave -valuecolwidth 110
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
WaveRestoreZoom {0 ps} {1032 ps}
