onerror {resume}
quietly virtual function -install /DE1_SoC_testbench/dut -env /DE1_SoC_testbench/#INITIAL#190 { &{/DE1_SoC_testbench/dut/SW[8], /DE1_SoC_testbench/dut/SW[7], /DE1_SoC_testbench/dut/SW[6], /DE1_SoC_testbench/dut/SW[5], /DE1_SoC_testbench/dut/SW[4] }} LFSR_COMPARE_SWITCH
quietly virtual function -install /DE1_SoC_testbench/dut -env /DE1_SoC_testbench/#INITIAL#190 { &{/DE1_SoC_testbench/dut/SW[3], /DE1_SoC_testbench/dut/SW[2], /DE1_SoC_testbench/dut/SW[1], /DE1_SoC_testbench/dut/SW[0] }} SpeedModifier
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/dut/GPIO_1
add wave -noupdate /DE1_SoC_testbench/dut/CLOCK_50
add wave -noupdate /DE1_SoC_testbench/dut/SYSTEM_CLOCK
add wave -noupdate /DE1_SoC_testbench/dut/HEX0
add wave -noupdate /DE1_SoC_testbench/dut/HEX1
add wave -noupdate /DE1_SoC_testbench/dut/HEX2
add wave -noupdate /DE1_SoC_testbench/dut/HEX3
add wave -noupdate /DE1_SoC_testbench/dut/HEX4
add wave -noupdate /DE1_SoC_testbench/dut/HEX5
add wave -noupdate /DE1_SoC_testbench/dut/GrnPixels
add wave -noupdate /DE1_SoC_testbench/dut/LEDR
add wave -noupdate /DE1_SoC_testbench/dut/KEY
add wave -noupdate /DE1_SoC_testbench/dut/SW
add wave -noupdate -expand /DE1_SoC_testbench/dut/RedPixels
add wave -noupdate /DE1_SoC_testbench/dut/in0raw
add wave -noupdate /DE1_SoC_testbench/dut/in1raw
add wave -noupdate /DE1_SoC_testbench/dut/in2raw
add wave -noupdate /DE1_SoC_testbench/dut/in3raw
add wave -noupdate /DE1_SoC_testbench/dut/in0
add wave -noupdate /DE1_SoC_testbench/dut/in1
add wave -noupdate /DE1_SoC_testbench/dut/in2
add wave -noupdate /DE1_SoC_testbench/dut/in3
add wave -noupdate -radix decimal /DE1_SoC_testbench/dut/total_points
add wave -noupdate -radix decimal /DE1_SoC_testbench/dut/col1_points
add wave -noupdate -radix decimal /DE1_SoC_testbench/dut/col2_points
add wave -noupdate -radix decimal /DE1_SoC_testbench/dut/col3_points
add wave -noupdate -radix decimal /DE1_SoC_testbench/dut/col4_points
add wave -noupdate /DE1_SoC_testbench/dut/col_1_score
add wave -noupdate /DE1_SoC_testbench/dut/col_2_score
add wave -noupdate /DE1_SoC_testbench/dut/col_3_score
add wave -noupdate /DE1_SoC_testbench/dut/col_4_score
add wave -noupdate /DE1_SoC_testbench/dut/SpeedModifier
add wave -noupdate /DE1_SoC_testbench/dut/pulse1
add wave -noupdate /DE1_SoC_testbench/dut/pulse2
add wave -noupdate /DE1_SoC_testbench/dut/pulse3
add wave -noupdate /DE1_SoC_testbench/dut/pulse4
add wave -noupdate /DE1_SoC_testbench/dut/enable
add wave -noupdate /DE1_SoC_testbench/dut/shift
add wave -noupdate /DE1_SoC_testbench/dut/LFSR_COMPARE_SWITCH
add wave -noupdate /DE1_SoC_testbench/dut/LFSRbank1
add wave -noupdate /DE1_SoC_testbench/dut/LFSRbank2
add wave -noupdate /DE1_SoC_testbench/dut/LFSRbank3
add wave -noupdate /DE1_SoC_testbench/dut/LFSRbank4
add wave -noupdate /DE1_SoC_testbench/dut/LFSRoutput
add wave -noupdate /DE1_SoC_testbench/dut/reset
add wave -noupdate /DE1_SoC_testbench/dut/indicator1
add wave -noupdate /DE1_SoC_testbench/dut/indicator2
add wave -noupdate /DE1_SoC_testbench/dut/indicator3
add wave -noupdate /DE1_SoC_testbench/dut/indicator4
add wave -noupdate /DE1_SoC_testbench/dut/bank1
add wave -noupdate /DE1_SoC_testbench/dut/bank2
add wave -noupdate /DE1_SoC_testbench/dut/bank3
add wave -noupdate /DE1_SoC_testbench/dut/bank4
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {AddToNegative {82532325 ps} 1} {{Start Input Tests} {80002750 ps} 1} {{Cursor 3} {83147100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 131
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
WaveRestoreZoom {82163141 ps} {82901509 ps}
