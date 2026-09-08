Final project from EE271 at UW Seattle in Spring26. Should not be used for this course in the future.
The Verilog project and its necessary output and input routing files are designed to run on DE1-SoC FPGA Cyclone V (5CSEMA5F31C6N).
Written in Quartus in System Verilog.
The project is based moderately closely to a provided spec:
--Implement a simplified version of “Dance-Dance Revolution”. Your machine will have four
banks of lights, each bank with at least 5 lights. The 2nd to top light in each bank is a different
color. Each bank of lights also has a button. The system will randomly turn on a light at the
bottom of a bank, which will quickly move up that bank (one light on at a time, going from
bottom to top). The goal is for the user to press the button on a bank of lights right when the
light hits the 2nd to top position. If the user times it right, they get 2 points. If they get it in a
position next to that goal position, they get 1 point. Pressing at any other point, or letting the
light go off the top, you lose 2 points. Your system should keep track of the score over time,
to see how well the player is doing. To make it interesting, multiple lights can go at once, and
speed can be adjusted by speeding up/slowing down the machine (manually by the user).--

However, the game is much closely thought of as a piano tile game where tiles (lights) descend the screen and must be pressed with the appropriate rhythm.
While there is no music associated to this FPGA game, the inputs must be timed with the outputs.

The code here includes numerous modules that are not used for the full project. This is due to the design of the class where each lab was best made as a continuing copy of a previous lab.
Additionally included is the modelSim for testbenches. It possesses a shortcut to the application, thought that shortcut is to its original location while the project was underway.
