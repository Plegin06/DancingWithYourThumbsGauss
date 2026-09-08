onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /total_adder_testbench/dut/in1
add wave -noupdate -radix decimal /total_adder_testbench/dut/in2
add wave -noupdate -radix decimal /total_adder_testbench/dut/in3
add wave -noupdate -radix decimal /total_adder_testbench/dut/in4
add wave -noupdate -radix decimal /total_adder_testbench/dut/in1pad
add wave -noupdate -radix decimal /total_adder_testbench/dut/in2pad
add wave -noupdate -radix decimal /total_adder_testbench/dut/in3pad
add wave -noupdate -radix decimal /total_adder_testbench/dut/in4pad
add wave -noupdate -radix decimal /total_adder_testbench/dut/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {495 ps} 0}
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
WaveRestoreZoom {0 ps} {168 ps}
