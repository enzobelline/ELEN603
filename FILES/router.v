module router(clock_ingress, clock_egress, reset_n, frame_n, valid_n, di, dout, valido_n, frameo_n);
input clock_ingress, clock_egress, reset_n; // clock signal
input reg [7:0] frame_n, valid_n, di; // binary input
output reg [7:0] valido_n, frameo_n,dout;
// This is our DUT
wire [3:0] addr_from_input [7:0]; // all the destination addrewire [31:0] payload_from_input [7:0]; // payloads
wire [31:0] payload_from_input [7:0]; // payloads
wire [7:0] vld_from_input ;
wire [7:0] vld_from_mux;
wire [7:0] clear_from_fabric;
wire [31:0] payload_from_fifo [7:0];
wire [31:0] payload_from_mux [7:0];
wire [7:0] fifo_empty ;
wire [7:0] req_to_arb[7:0] ;
wire [7:0] request_to_fifo ;
reg [7:0] clear;

/* generate hardware
8 port ins,  8 muxs, 8fifos, 8 port outs
*/
genvar i;
generate
for (i=0;i<8;i=i+1) begin :inst
  portin port(.clock(clock_ingress),.reset_n(reset_n),.frame_n(frame_n[i]), .valid_n(valid_n[i]),.clr(clear[i]), .di(di[i]), 
  .addr(addr_from_input[i]),.payload(payload_from_input[i]),.vld(vld_from_input[i]) );
  //Arbiter arbiter (.clk(clock_ingress), .rst_n(reset_n), .req(req_to_arb[i]), .gnt(grant[i]));
  Mux8x1 mux8x1(.clock(clock_ingress), .reset_n(reset_n),  .datain(payload_from_input) , .x(i),.clr(clear[i]), .valid_from_mux(vld_from_mux[i]) ,
  .vld_from_input( vld_from_input),.addr_from_input(addr_from_input) , .datout(payload_from_mux[i]) );
  Fifo fifo (.clk_push(clock_ingress), .clk_pop(clock_egress),.reset_n(reset_n),
  .push_req_n(vld_from_mux[i]), .pop_req_n(!request_to_fifo[i]), .data_in(payload_from_mux[i]), 
  .clear(fifo_empty[i]), .data_out(payload_from_fifo[i]));
  portout portout ( .clock(clock_egress), .vld(fifo_empty[i]), .reset_n(reset_n), .din(payload_from_fifo[i]),
  .dout(dout[i]), .frameo_n(frameo_n[i]), .valido_n(valido_n[i]), .pop(request_to_fifo[i])
  );
end
endgenerate
always @(posedge clock_ingress, negedge reset_n)begin
  if(!reset_n)begin
    clear[0]<=0;
    clear[1]<=0;
    clear[2]<=0;
    clear[3]<=0;
    clear[4]<=0;
    clear[5]<=0;
    clear[6]<=0;
    clear[7]<=0;
  end
  if(fifo_empty[0]==1)begin
    clear[0]<=1;
  end
  if(fifo_empty[1]==1)begin
    clear[1]<=1;
  end
  if(fifo_empty[2]==1)begin
    clear[2]<=1;
  end
  if(fifo_empty[3]==1)begin
    clear[3]<=1;
  end
  if(fifo_empty[4]==1)begin
    clear[4]<=1;
  end
  if(fifo_empty[5]==1)begin
    clear[5]<=1;
  end
  if(fifo_empty[6]==1)begin
    clear[6]<=1;
  end
  if(fifo_empty[7]==1)begin
    clear[7]<=1;
  end
end



endmodule