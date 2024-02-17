module a1(bit_in,clock,reset,outFlag);
input clock; // clock signal
input reset; // reset input
input bit_in; // binary input
output reg outFlag; // output of the sequence detector

parameter  	
	Zero=0, // "Zero" State
	One=1, // "One" State
	OneOne=2, // "OneOne" State
	ZeroOneOne=3; // "ZeroOneOne" State
reg [2:0] current_state; // current state
// sequential memory of the Moore FSM
always @(posedge clock, negedge reset)
begin
	if(!reset)
		outFlag<=0;
		current_state <= Zero;// when reset=1, reset the state of the FSM to "Zero" State
	else
	case(current_state) 
	Zero:begin
		outFlag<=0;
		if(bit_in==1)
			current_state <= One;
	end
	One:begin
		if(bit_in==1) //pattern is immediately null
			current_state <= OneOne; 
		else 
			current_state <= Zero; 
	end
	OneOne:begin//01 or 0...01
		if(bit_in==0) //possible pattern continuation
			current_state <= ZeroOneOne; 
	end 
	ZeroOneOne:begin//101 or 10...01
		if(bit_in==1) //PATTERNFOUND
			current_state <= Zero;
			outFlag <= 1;
	end 
	endcase


end
endmodule
