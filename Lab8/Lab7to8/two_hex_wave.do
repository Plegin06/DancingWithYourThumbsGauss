onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Diplays -label {HEX0 Digit0} -radix symbolic /two_hex_testbench/dut/HEX0
add wave -noupdate -expand -group Diplays -label {HEX1 Digit1} -radix binary -childformat {{{/two_hex_testbench/dut/HEX1[6]} -radix unsigned} {{/two_hex_testbench/dut/HEX1[5]} -radix unsigned} {{/two_hex_testbench/dut/HEX1[4]} -radix unsigned} {{/two_hex_testbench/dut/HEX1[3]} -radix unsigned} {{/two_hex_testbench/dut/HEX1[2]} -radix unsigned} {{/two_hex_testbench/dut/HEX1[1]} -radix unsigned} {{/two_hex_testbench/dut/HEX1[0]} -radix unsigned}} -subitemconfig {{/two_hex_testbench/dut/HEX1[6]} {-height 15 -radix unsigned} {/two_hex_testbench/dut/HEX1[5]} {-height 15 -radix unsigned} {/two_hex_testbench/dut/HEX1[4]} {-height 15 -radix unsigned} {/two_hex_testbench/dut/HEX1[3]} {-height 15 -radix unsigned} {/two_hex_testbench/dut/HEX1[2]} {-height 15 -radix unsigned} {/two_hex_testbench/dut/HEX1[1]} {-height 15 -radix unsigned} {/two_hex_testbench/dut/HEX1[0]} {-height 15 -radix unsigned}} /two_hex_testbench/dut/HEX1
add wave -noupdate -expand -group {Digit 0} {/two_hex_testbench/dut/SW[3]}
add wave -noupdate -expand -group {Digit 0} {/two_hex_testbench/dut/SW[2]}
add wave -noupdate -expand -group {Digit 0} {/two_hex_testbench/dut/SW[1]}
add wave -noupdate -expand -group {Digit 0} {/two_hex_testbench/dut/SW[0]}
add wave -noupdate -expand -group {Digit 1} {/two_hex_testbench/dut/SW[7]}
add wave -noupdate -expand -group {Digit 1} {/two_hex_testbench/dut/SW[6]}
add wave -noupdate -expand -group {Digit 1} {/two_hex_testbench/dut/SW[5]}
add wave -noupdate -expand -group {Digit 1} {/two_hex_testbench/dut/SW[4]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23 ps} 0}
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
