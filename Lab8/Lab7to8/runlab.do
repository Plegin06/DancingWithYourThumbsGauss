# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./Nordstrom.sv"
vlog "./two_hex.sv"
vlog "./seg7.sv"
vlog "./FHUS.sv"
vlog "./FHUS_Nordstrom.sv"
vlog "./simple.sv"
vlog "./clock_divider.sv"
vlog "./DE1_SoC.sv"
vlog "./airport_lights.sv"
vlog "./centerLight.sv"
vlog "./normalLight.sv"
vlog "./victory_condition.sv"
vlog "./tug_input.sv"
vlog "./hex_winner.sv"
vlog "./input_validator.sv"
vlog "./hex_counter.sv"
vlog "./LFSR_four.sv"
vlog "./LFSR_ten.sv"
vlog "./ten_comparator.sv"
vlog "./LED_cascade.sv"
vlog "./input_attempt.sv"
vlog "./clock_counter.sv"
vlog "./LFSR_counter.sv"
vlog "./LFSR_twentyfour.sv"
vlog "./pulse_verifier.sv"
vlog "./point_adder.sv"
vlog "./total_adder.sv"
vlog "./hex_number_picker.sv"
vlog "./point_displayer.sv"
vlog "./LEDDriver.sv"
vlog "./col_freezer.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do DE1_SoC_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
