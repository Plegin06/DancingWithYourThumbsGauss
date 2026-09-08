onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /normalLight_testbench/dut/clk
add wave -noupdate /normalLight_testbench/dut/reset
add wave -noupdate /normalLight_testbench/dut/L
add wave -noupdate /normalLight_testbench/dut/RN
add wave -noupdate /normalLight_testbench/dut/R
add wave -noupdate /normalLight_testbench/dut/LN
add wave -noupdate /normalLight_testbench/dut/lightOn
add wave -noupdate /normalLight_testbench/dut/ps
add wave -noupdate /normalLight_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Reset Steps} {649 ps} 0} {{OFF L=1 no move} {837 ps} 0} {{L + RN lighton} {1343 ps} 0} {{lightOff L and R} {1724 ps} 0} {{LN + R lighton} {2036 ps} 0} {{Reset Holds Off} {2828 ps} 0} {{Cursor 7} {3384 ps} 0}
quietly wave cursor active 7
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
WaveRestoreZoom {2079 ps} {4259 ps}
