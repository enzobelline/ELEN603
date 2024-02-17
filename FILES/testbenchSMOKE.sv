`timescale 1ns/1ps

// This is a simple testbench you can use to test out your 8x8 switch
logic [31:0] queue[$]; 
integer NUM_ERRORS=0; 
module tb;
reg reset_n,clock_ingress,clock_egress;
initial clock_ingress=0; 
initial clock_egress=0;
initial reset_n=1; 
// Used for reporting summary
reg [7:0] da_sent_pkts [8];
reg [7:0] da_rcvd_pkts [8];
reg [7:0] sa_sent_pkts [8];
integer j;

/*Verilog thinks in bits, so reg [7:0] a[0:3] will give you a 4x8 bit array (=4x1 byte array). 
You get the first byte out of this with a[0]. The third bit of the 2nd byte is a[1][2].
*/
// wire [7:0] grant [7:0]; // one-hot vector ie : grant=0001000Wire [7:0] grant_index [2:0] // 
// wire [7:0] grant_index [2:0]; // bit position, grant_inde

// Initialized our reporting data structure 
initial begin
  for (j=0;j<8;j=j+1) begin
    da_sent_pkts[j]=0;
    da_rcvd_pkts[j]=0;
    sa_sent_pkts[j]=0;
  end
end
// Clock Generator
`ifdef CLOCK1
initial $display("Clock Delays are 50,50"); 
always #50 clock_ingress=!clock_ingress; 
always #50 clock_egress=!clock_egress; 
`elsif CLOCK2
initial $display("Clock Delays are 51,5"); 
always #51 clock_ingress=!clock_ingress; 
always #5 clock_egress=!clock_egress; 
`elsif CLOCK3
initial $display("Clock Delays are 5,51"); 
always #5 clock_ingress=!clock_ingress; 
always #51 clock_egress=!clock_egress; 
`elsif CLOCK4
initial $display("Clock Delays are 50,51"); 
always #50 clock_ingress=!clock_ingress; 
always #51 clock_egress=!clock_egress; 
`else
initial $display("Clock Delays are 51,50"); 
always #51 clock_ingress=!clock_ingress; 
always #50 clock_egress=!clock_egress; 
`endif

reg [7:0] di, frame_n, valid_n;
wire  [7:0] dout, valido_n, frameo_n;
initial di <= 8'bxxxx_xxxx; 

// This is our DUT
router dut(
  .clock_ingress(clock_ingress),
  .clock_egress(clock_egress),
  //.clk(clock),
  .reset_n(reset_n),
  .frame_n(frame_n),
  .valid_n(valid_n),
  .di(di),
  //.din(di),
  .dout(dout),
  .valido_n(valido_n),
  .frameo_n(frameo_n)
);

// We have a monitor connected to all 8 ports  
 monitor #(0)  outmonitor1(clock_egress, reset_n, dout[0], frameo_n[0], valido_n[0]);
 monitor #(1)  outmonitor2(clock_egress, reset_n, dout[1], frameo_n[1], valido_n[1]);
 monitor #(2)  outmonitor3(clock_egress, reset_n, dout[2], frameo_n[2], valido_n[2]);
 monitor #(3)  outmonitor4(clock_egress, reset_n, dout[3], frameo_n[3], valido_n[3]);
 monitor #(4)  outmonitor5(clock_egress, reset_n, dout[4], frameo_n[4], valido_n[4]);
 monitor #(5)  outmonitor6(clock_egress, reset_n, dout[5], frameo_n[5], valido_n[5]);
 monitor #(6)  outmonitor7(clock_egress, reset_n, dout[6], frameo_n[6], valido_n[6]);
 monitor #(7)  outmonitor8(clock_egress, reset_n, dout[7], frameo_n[7], valido_n[7]);

reg dummy; 
// Initialization of inputs to the switch 
initial begin di=0; frame_n=8'hff; valid_n=8'hff; // Let's reset the switch
repeat(2) @(posedge clock_ingress) ;
reset_n = 0;
repeat(4) @(posedge clock_ingress) ;
reset_n = 1;
repeat (10) @(posedge clock_ingress); 

//  Main part of testbench to send stimulus to DUT
// setpkt (source address, destination address, payload)

if ($test$plusargs("SMOKE")) begin 
  $display("STARTING SMOKE TEST!!!!"); 
  sendpkt(0,7,32'hdead_beef); 
end

else if ($test$plusargs("1PORT")) begin 
  $display("STARTING 1-PORT TEST!!!!"); 
  sendpkt(0,0,32'h1234_1234); 
  sendpkt(0,1,32'hdead_beef); 
  sendpkt(0,2,32'h9876_abcd); 
  sendpkt(0,3,32'h5555_5555); 
  sendpkt(0,4,32'hcafe_cafe); 
  sendpkt(0,5,32'habcd_dcba); 
  sendpkt(0,6,32'h5455_5050); 
  sendpkt(0,7,32'h0000_1111); 
end

else if ($test$plusargs("4PORT")) begin 
  $display("STARTING 4-PORT TEST!!!!"); 
  fork 
    repeat(10) sendpkt(0,3,$random); 
    repeat(10) sendpkt(1,2,$random); 
    repeat(10) sendpkt(2,1,$random); 
    repeat(10) sendpkt(3,0,$random); 
  join
end

else if ($test$plusargs("MINI_CONCURRENT")) begin 
  $display("STARTING CONCURRENT TEST!!!!"); 
  fork 
    repeat(4) sendpkt(0,7,$random); 
    repeat(4) sendpkt(1,7,$random); 
  join
end
else if ($test$plusargs("CONCURRENT")) begin 
  $display("STARTING CONCURRENT TEST!!!!"); 
  fork 
    repeat(4) sendpkt(0,7,$random); 
    repeat(4) sendpkt(1,7,$random); 
    repeat(4) sendpkt(2,7,$random); 
    repeat(4) sendpkt(3,7,$random); 
  join
end
else if ($test$plusargs("RANDOM")) begin 
  $display("STARTING CONCURRENT TEST!!!!"); 
  fork
    repeat(40) #($urandom_range(0,100)) sendpkt(0,$urandom_range(0,7),$random); 
    repeat(40) #($urandom_range(0,100)) sendpkt(1,$urandom_range(0,7),$random); 
    repeat(40) #($urandom_range(0,100)) sendpkt(2,$urandom_range(0,7),$random); 
    repeat(40) #($urandom_range(0,100)) sendpkt(3,$urandom_range(0,7),$random); 
    repeat(40) #($urandom_range(0,100)) sendpkt(4,$urandom_range(0,7),$random); 
    repeat(40) #($urandom_range(0,100)) sendpkt(5,$urandom_range(0,7),$random); 
    repeat(40) #($urandom_range(0,100)) sendpkt(6,$urandom_range(0,7),$random); 
    repeat(40) #($urandom_range(0,100)) sendpkt(7,$urandom_range(0,7),$random); 
  join
end

else begin 
  $display("STARTING SMOKE TEST!!!!"); 
  sendpkt(0,0,32'hdead_beef); 
end

#200000 $finish;
end

final begin 
$display("\n*******************End of Simulation Report*******************" ); 
$display("\nNumber of Errors = %d",NUM_ERRORS); 
$display("Number of unmatched packets = %d", queue.size()); 
for (j=0;j<8;j=j+1) begin 
  $display("Port %2d [transmitted=%d] [received=%d] [expected=%d]",j ,sa_sent_pkts[j],da_rcvd_pkts[j],da_sent_pkts[j]); 
end
end

// Task to send packet 
task automatic  sendpkt (input [3:0] sa, da, input [31:0] data); 
integer i; 
begin 
queue.push_front(data); 
$display("Sending packet @%5t [sa=%d] [da=%d] data=%h",$time,sa,da,data); 
da_sent_pkts[da] = da_sent_pkts[da] + 1; 
sa_sent_pkts[sa] = sa_sent_pkts[sa] + 1; 
  @(posedge clock_ingress); 
  frame_n[sa]  <= 1'b0; 
  di[sa] <= da[0]; 
@(posedge clock_ingress)  di[sa] <= da[1]; 
@(posedge clock_ingress)  di[sa] <= da[2]; 
@(posedge clock_ingress)  di[sa] <= 1'b0; 
// Padding
repeat(1) @(posedge clock_ingress) ; 
for (i=0;i<32;i=i+1) begin 
  valid_n[sa] <= 0; 
  di[sa] <= data[i]; 
  frame_n[sa] <= i==31; 
  @(posedge clock_ingress); 
end
valid_n[sa] <= 1'b1; 
di[sa] <= 1'bx; 
repeat (10)  @(posedge clock_ingress); 
end
endtask 
endmodule

module monitor(input clock, reset_n, data_in, frame_n, valid_n); 
int index[$]; 
parameter port=0; 
integer i; 
reg [31:0]  data; 
reg in_progress; 
logic found; 
initial begin 
  in_progress = 0; 
  @(negedge reset_n);  
  @(posedge reset_n);  
  forever begin 
    in_progress = 0; 
    while  (frame_n | valid_n) @(posedge clock) ; 
    in_progress = 1; 
    tb.da_rcvd_pkts[port] = tb.da_rcvd_pkts[port] + 1; 
    for (i=0;i<32;i=i+1) begin 
    data[i] <= data_in;  
    @(posedge clock); 
  end
  found=1'b0; 
  foreach (queue[i])  begin 
      if (data == queue[i])  
      begin 
        queue.delete(i); 
        $display("Received %h @%5t and match found  ",data,$time); 
        found = 1'b1; 
        break;
     end
  end
      if (!found) begin 
        $display("!!!!!!!!!!!!!!!ERROR!, data mismatch with %h",data); 
        NUM_ERRORS++; 
    end
  end
end
endmodule

/*
Vld: high, when payload,address
 is available, and not yet routed
 handshake to the fabric
Clear: payload was accepted by fifo
 vld,clear are both handshake for each oth
*/
module portin (input clock,reset_n, frame_n, valid_n, di, clr, output reg[31:0] payload,
output reg [3:0] addr, output reg vld);
  reg [5:0] cnta,cntp;
    always @(posedge clock, negedge reset_n)
    if (!reset_n) begin // or clear?
      cnta <= 0;
      cntp <= 0;
      vld <= 0;
    end
    else begin
      if (!frame_n && valid_n) begin
        if (cnta < 4) addr[cnta] <= di;
        cnta <= cnta + 1;
    end
    else if (!frame_n && !valid_n) begin
      payload[cntp] <= di;
      cntp <= cntp + 1;
    end

    else if (frame_n && !valid_n) begin
      payload[cntp] <= di;
      vld <= 1;
      cnta <= 0;
      cntp <= 0;
      end
    else if (clr) begin
      vld <= 0; // WRONG: too late//created logic in router.v that sets clear immediately if fifo is notempty
      cnta <= 0;
      cntp <= 0;  
    end
    end
endmodule

module Mux8x1(clock, reset_n, datain, x,clr,valid_from_mux,vld_from_input,addr_from_input, datout);
  input reg [7:0] vld_from_input ;
  input reg clock, reset_n;
  input reg clr;
  input reg [31:0]x;
  input reg [3:0] addr_from_input [7:0];
  input reg [31:0] datain [7:0]; // payloads
  output reg valid_from_mux;
  output reg[31:0] datout;
  integer i;
  always@(*)  begin
    if(vld_from_input[0]==1)begin
      if(addr_from_input[0]==x)begin
        datout=datain[0]; 
        valid_from_mux<=1;
      end
    end
    if(vld_from_input[1]==1)begin
      if(addr_from_input[1]==x)begin
        datout=datain[1]; 
        valid_from_mux<=1;
      end
    end
    if(vld_from_input[2]==1)begin
      if(addr_from_input[2]==x) begin 
        datout=datain[2]; 
        valid_from_mux<=1;
      end
    end
    if(vld_from_input[3]==1)begin
      if(addr_from_input[3]==x)begin
        datout=datain[3]; 
        valid_from_mux<=1;
      end
    end
    if(vld_from_input[4]==1)begin
      if(addr_from_input[4]==x)begin
        datout=datain[4]; 
        valid_from_mux<=1;
      end
    end
    if(vld_from_input[5]==1)begin
      if(addr_from_input[5]==x) begin
        datout=datain[5]; 
        valid_from_mux<=1;
      end
    end   
    if(vld_from_input[6]==1)begin
      if(addr_from_input[6]==x)begin 
        datout=datain[6]; 
        valid_from_mux<=1;
      end
    end
    if(vld_from_input[7]==1)begin
      if(addr_from_input[7]==x)begin 
        datout=datain[7]; 
        valid_from_mux<=1;
      end
    end 
    end
    parameter  	
        readenable=0, // "Zero" State
        validState=1; // "One" State
	// payloadState=2, // "OneOne" State
	// addr=3, // "ZeroOneOne" State
	// writeout=4; // "ZeroOneOne" State
    reg [3:0] current_state; // current state  
    always @(posedge clock, negedge reset_n)begin
        if(!reset_n)
            current_state<=readenable;
            valid_from_mux<=0;
        case(current_state) 
          readenable:begin
            if(valid_from_mux) current_state <= validState;// when reset=1, reset the state of the FSM to "Zero" State      
          end
          validState:begin
            valid_from_mux <=0; // issue a pop
            current_state<=readenable;
          end
        endcase
    end
  // always@(*)  begin
  //   case(valid_n)
  //     8'b1??????? : datout=datain[0];
  //     8'b01?????? : datout=datain[1];
  //     8'b001????? : datout=datain[2];
  //     8'b0001???? : datout=datain[3];
  //     8'b00001??? : datout=datain[4];
  //     8'b000001?? : datout=datain[5];
  //     8'b0000001? : datout=datain[6];
  //     8'b000000?1 : datout=datain[7];
  //     default:datout=1'b0;
  //   endcase
  // end
endmodule

module Fifo(input clk_push, clk_pop, reset_n, push_req_n, pop_req_n,
input reg [31:0]data_in, 
output reg clear,
output reg[31:0] data_out);
  //when payload pushed on fifo need to immediately drop the “vld” request 
  reg[31:0] stack[10:0];
  integer head=0;
  integer tail=0;
  integer i;
  parameter  	
        PopReady=0, // "Zero" State
        Wait=1;     
    reg popState;
  always @(posedge clk_push,negedge reset_n)begin
    if (!reset_n) begin // or clear?
      head <=0;
      tail <= 0;
      clear <= 0;
      data_out <= 0;  
      popState<=0;
    end 
    else begin   
        if(push_req_n) begin
            stack[tail] <= data_in;
            tail <= tail+1;
            clear<=1;
        end
        case(popState)
            PopReady:begin
                if(!pop_req_n)begin
                    data_out <= stack[head];//make this 8 bits instead
                    stack[head]<=0;
                    head <= head+1;
                    popState<=Wait;
                end
            end  
            Wait:begin
                if(head==tail)clear<=0;
                if(pop_req_n)popState<=PopReady;
            end
        endcase
    end  
    end
         
endmodule

module portout(input clock, vld, reset_n, input reg [31:0] din, 
  output reg dout, output reg frameo_n, valido_n, pop); //serial output
//Payload -> {valido_n, fameo_n, dout} 
//if redy is high then issue a pop
  reg [5:0] cntp,cnta;
  reg [31:0] payload;
  parameter  	
	Wait=0, // "Zero" State
	validState=1, // "One" State
	payloadState=2, // "OneOne" State
	addr=3, // "ZeroOneOne" State
	writeout=4; // "ZeroOneOne" State
  reg [3:0] current_state; // current state
    always @(posedge clock, negedge reset_n)
      if (!reset_n) begin // or clear?
        cnta <= 0;
        cntp <= 0;
        payload<=0;
        frameo_n <= 1;
        valido_n <= 1;
        pop <= 0;  
		current_state <= Wait;// when reset=1, reset the state of the FSM to "Zero" State      end
      end
      else begin
        case(current_state) 
          Wait:begin
            if(vld) current_state <= validState;// when reset=1, reset the state of the FSM to "Zero" State      
          end
          validState:begin
            pop <=1; // issue a pop
            current_state<=payloadState;
          end
          payloadState:begin
            current_state<=addr;
          end
          addr:begin
            payload<=din;
            frameo_n <= 0;
            cnta<=cnta+1;
            if(cnta==3)current_state<=writeout;
          end          
          writeout:begin
            valido_n <= 0;
            dout<= payload[cntp];
            cntp <= cntp + 1;
            if(cntp==32) begin
              pop<=0;
              valido_n <= 1; 
              frameo_n <= 1; 
              cnta<=0;
              cntp<=0;
              payload<=0;
              current_state<=Wait;
            end
          end 
          endcase

      //   if (vld) begin
      //     pop <=1; // issue a pop
      //     payload<=din;
      //     frameo_n<=0;
      //   end
      //   else if(vld && !payload) begin
      //     pop<=0;
      //     //dout<= payload[cnta];
      //     cnta <= cnta + 1;
      //     if(cnta==3) begin
      //       valido_n <= 0; 
      //     end
      // end            
      //   else if (!frameo_n && !valido_n) begin
      //     pop<=0;
      //     frameo_n <= 0;
      //     valido_n <= 0;
      //     dout<= payload[cntp];
      //     cntp <= cntp + 1;
      //     if(cntp==32) begin
      //       valido_n <= 1; 
      //       frameo_n <= 1; 
      //       cnta<=0;
      //       cntp<=0;
      //       payload<=0;
      //     end
      //   end    
      end    
    
endmodule

module Arbiter (input clk, rst_n, input [7:0] req, output reg [7:0] gnt);
  reg [2:0] cnt;
  reg [7:0] gnt_i [7:0];
  always @(posedge clk, negedge rst_n)begin
    if (!rst_n) cnt <= 3'b0;
    else if (cnt==7) cnt <= 3'b0; else cnt <= cnt +1;
  end
  pri_encoder encoder1 (.enable(cnt==0), .sel(  {req[0],req[1],req[2],req[3],req[4],req[5],req[6],req[7]} ), 
  .z( {gnt_i[0][0],gnt_i[1][0],gnt_i[2][0],gnt_i[3][0],gnt_i[4][0],gnt_i[5][0], gnt_i[6][0],gnt_i[7][0]}));
  pri_encoder encoder2 (.enable(cnt==1), .sel(  {req[1],req[2],req[3],req[4],req[5],req[6],req[7],req[0]}), 
  .z( {gnt_i[1][1],gnt_i[2][1],gnt_i[3][1],gnt_i[4][1],gnt_i[5][1],gnt_i[6][1], gnt_i[7][1],gnt_i[0][1]}));
  pri_encoder encoder3 (.enable(cnt==3), .sel(  {req[2],req[3],req[4],req[5],req[6],req[7],req[0],req[1]}), 
  .z( {gnt_i[2][2],gnt_i[3][2],gnt_i[4][2],gnt_i[5][2],gnt_i[6][2],gnt_i[7][2], gnt_i[0][2],gnt_i[1][2]}));
  pri_encoder encoder4 (.enable(cnt==3), .sel(  {req[3],req[4],req[5],req[6],req[7],req[0],req[1],req[2]}), 
  .z( {gnt_i[3][3],gnt_i[4][3],gnt_i[5][3],gnt_i[6][3],gnt_i[7][3],gnt_i[0][3], gnt_i[1][3],gnt_i[2][3]}));
  pri_encoder encoder5 (.enable(cnt==4), .sel(  {req[4],req[5],req[6],req[7],req[0],req[1],req[2],req[3]}), 
  .z( {gnt_i[4][4],gnt_i[5][4],gnt_i[6][4],gnt_i[7][4],gnt_i[0][4],gnt_i[1][4], gnt_i[2][4],gnt_i[3][4]}));
  pri_encoder encoder6 (.enable(cnt==5), .sel(  {req[5],req[6],req[7],req[0],req[1],req[2],req[3],req[4]}), 
  .z( {gnt_i[5][5],gnt_i[6][5],gnt_i[7][5],gnt_i[0][5],gnt_i[1][5],gnt_i[2][5], gnt_i[3][5],gnt_i[4][5]}));
  pri_encoder encoder7 (.enable(cnt==6), .sel(  {req[6],req[7],req[0],req[1],req[2],req[3],req[4],req[5]}), 
  .z( {gnt_i[6][6],gnt_i[7][6],gnt_i[0][6],gnt_i[1][6],gnt_i[2][6],gnt_i[3][6], gnt_i[4][6],gnt_i[5][6]}));
  pri_encoder encoder8 (.enable(cnt==7), .sel(  {req[7],req[0],req[1],req[2],req[3],req[4],req[5],req[6]}), 
  .z( {gnt_i[7][7],gnt_i[0][7],gnt_i[1][7],gnt_i[2][7],gnt_i[3][7],gnt_i[4][7], gnt_i[5][7],gnt_i[6][7]}));

  always @(posedge clk) begin
    gnt[0] <= gnt_i[0][0] || gnt_i[0][1] || gnt_i[0][2] || gnt_i[0][3] || gnt_i[0][4] || gnt_i[0][5] || gnt_i[0][6] || gnt_i[0][7];
    gnt[1] <= gnt_i[1][0] || gnt_i[1][1] || gnt_i[1][2] || gnt_i[1][3] || gnt_i[1][4] || gnt_i[1][5] || gnt_i[1][6] || gnt_i[1][7];
    gnt[2] <= gnt_i[2][0] || gnt_i[2][1] || gnt_i[2][2] || gnt_i[2][3] || gnt_i[2][4] || gnt_i[2][5] || gnt_i[2][6] || gnt_i[2][7];
    gnt[3] <= gnt_i[3][0] || gnt_i[3][1] || gnt_i[3][2] || gnt_i[3][3] || gnt_i[3][4] || gnt_i[3][5] || gnt_i[3][6] || gnt_i[3][7];
    gnt[4] <= gnt_i[4][0] || gnt_i[4][1] || gnt_i[4][2] || gnt_i[4][3] || gnt_i[4][4] || gnt_i[4][5] || gnt_i[4][6] || gnt_i[4][7];
    gnt[5] <= gnt_i[5][0] || gnt_i[5][1] || gnt_i[5][2] || gnt_i[5][3] || gnt_i[5][4] || gnt_i[5][5] || gnt_i[5][6] || gnt_i[5][7];
    gnt[6] <= gnt_i[6][0] || gnt_i[6][1] || gnt_i[6][2] || gnt_i[6][3] || gnt_i[6][4] || gnt_i[6][5] || gnt_i[6][6] || gnt_i[6][7];
    gnt[7] <= gnt_i[7][0] || gnt_i[7][1] || gnt_i[7][2] || gnt_i[7][3] || gnt_i[7][4] || gnt_i[7][5] || gnt_i[7][6] || gnt_i[7][7];
  end
endmodule

module pri_encoder(input enable, input [7:0] sel, output reg [7:0] z);
always @*
  if (enable)
    casez (sel)
      7'b1?????? : z=7'b1000000;
      7'b01????? : z=7'b0100000;
      7'b001???? : z=7'b0010000;
      7'b0001??? : z=7'b0001000;
      7'b00001?? : z=7'b0000100;
      7'b000001? : z=7'b0000010;
      7'b0000001 : z=7'b0000001;
      endcase
  else
    z=7'b0000000;
endmodule