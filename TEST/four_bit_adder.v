module four_bit_adder(cout,sum,x,y,cin);
input [3:0] x,y;
input cin;
output [3:0] sum;
output cout;
wire c1,c2,c3;
// finish the code below
full_adder f1 (sum[0],c1,x[0],y[0],cin);
full_adder f2 (sum[1],c2,x[1],y[1],c1);
full_adder f3 (sum[2],c3,x[2],y[2],c2);
full_adder f4 (sum[3],cout,x[3],y[3],c3);
endmodule
