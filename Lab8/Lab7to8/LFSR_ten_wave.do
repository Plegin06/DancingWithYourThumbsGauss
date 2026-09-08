onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /LFSR_ten_testbench/dut/clk
add wave -noupdate /LFSR_ten_testbench/dut/reset
add wave -noupdate /LFSR_ten_testbench/dut/bitout
add wave -noupdate /LFSR_ten_testbench/dut/feedback
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
WaveRestoreZoom {0 ps} {1 ns}
