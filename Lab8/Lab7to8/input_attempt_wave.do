onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /input_attempt_testbench/dut/reset
add wave -noupdate /input_attempt_testbench/dut/clk
add wave -noupdate /input_attempt_testbench/dut/player_in
add wave -noupdate /input_attempt_testbench/dut/light_top
add wave -noupdate /input_attempt_testbench/dut/light_high
add wave -noupdate /input_attempt_testbench/dut/light_mark
add wave -noupdate /input_attempt_testbench/dut/light_low
add wave -noupdate /input_attempt_testbench/dut/score
add wave -noupdate /input_attempt_testbench/dut/can_score
add wave -noupdate /input_attempt_testbench/dut/scoring_zone
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {55 ps} 0}
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
WaveRestoreZoom {0 ps} {5828 ps}
