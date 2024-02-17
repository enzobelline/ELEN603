module testbench();
reg [3:0] x,y;
reg cin;
wire [3:0] sum;
wire cout;
four_bit_adder dut (.cout(cout), .sum(sum), .x(x), .y(y), .cin(cin) );


// Create the stimulus here



// Print out the inputs/outputs here





endmodule
