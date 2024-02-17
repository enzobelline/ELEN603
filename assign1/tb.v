module tb;

// Inputs
reg bit_in;
reg clock;
reg reset;

// Outputs
wire outFlag;

// Instantiate the Sequence Detector using Moore FSM
a1 dut (
	.bit_in(bit_in), 
	.clock(clock), 
	.reset(reset), 
	.outFlag(outFlag)
);
initial begin
clock = 0;
forever #10 clock = ~clock;
end 
initial begin
	// Initialize Inputs
	bit_in = 0;
	reset = 1;
	#40;
	    reset = 0;
	#20;
//0101 - Start > One > ZeroOne..... 
	bit_in = 1;
	#20;
	bit_in = 0;
	#20;
	bit_in = 1; 
	#20;
	bit_in = 0; 
	#20;
	reset = 1;
	#40;
    reset = 0;
	#20;

//00 - Start > Start > : '000'>'000'
	bit_in = 0; 
	#20;
	bit_in = 0;
	#20;
	reset = 1;
	#40;
    reset = 0;
	#20;
//1101- Zero > One > OneOne > ZeroOneOne > Zero // outFlag
	bit_in = 1;
	#20;
	bit_in = 1;
	#20;
	bit_in = 0; 
	#20;
	bit_in = 1; 
	#20;
	reset = 1;
	#40;
    reset = 0;
	#20;
//110001- Zero > One > OneOne > ZeroOneOne > ZeroOneOne > ZeroOneOne > Zero  // outFlag
	#20;
	bit_in = 1;
	#20;
	bit_in = 1;
	#20;
	bit_in = 0; 
	#20;
	bit_in = 0;
	#20;
	bit_in = 1; 
	#20;
	bit_in = 1; 
	#20;

end
	    
endmodule
