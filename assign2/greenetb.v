module testbench();
import "DPI" function read_image(output int rgb[] ); import "DPI" function gen_image(input int rgb[] );

reg clk=0;   always #5 clk = !clk ;
reg reset_n=0;
wire done;
int pict [320*240];
int pict2 [320*240];
integer i,j;
initial begin
  @(posedge clk);
  reset_n<=1;
  #1;
  read_image(pict);
$display("pict1 enter");
 for (i=0;i<320*240;i=i+1) begin
   dut.mem.mem_array[i*32+:31] = pict[i];
   if (i < 100)
   $display("%d %h %h", i,pict[i]  , dut.mem.mem_array[i*32+:31]) ;
   end


// for (i=0;i<320*240;i=i+1)
//  $display("%b",pict[i]);
// copy the original image to the memory
$display("pict1 done");
@done; // the mem should be done updated
$display("pict2 enter");
// copy the updated image to the local variable pict2  for (i=0;i<320*240;i=i+1)
   pict2[i] = dut.mem.mem_array[i*32+:31];  gen_image(pict2);
$display("pict2 done");
$finish;
end
  flip_horizontal_and_invert_color dut(.clk(clk), .reset_n(reset_n), .done(done)); endmodule

module flip_horizontal_and_invert_color (input clk, reset_n, output reg done); // this circuit should act as a finite state machine to read/write from the // memory to flip and invert the color // you can use as many ports of the memory as you want
// parameter width = 8;           // RANGE 1 to 8192
// parameter addr_width = 3;// RANGE 1 to 12
// parameter rst_mode = 0;      // RANGE 0 to 1

//module connectors
  wire en_w1_n, en_r1_n, en_w2_n, en_r2_n;
  reg [16:0] addr_w1, addr_r1,addr_w2, addr_r2;
  reg [23:0] data_r1, data_w1, data_r2, data_w2;
  reg [1:0]  state;

//counters
  reg [7:0]y;//256
  reg [16:0]x1,x2;//addr
    // Start=0,  // "Extra" State
    // Read=1,   // "Zero" State
    // Execute=2,// "Execute" State
    // Write=3;  // "Write" State
  always @ (posedge clk, negedge reset_n)
    if (!reset_n) begin
      y  <= 0;
      addr_r1=0;
      addr_r2=0;
      addr_w1=0;
      addr_w2=0;
      x1 <= 0;
      x2 <= 319; // 320x240 pixel dimensions
    end
    else begin
      if(state==2) begin//if we are in the read state
        if(y==240) begin// if we have ran through the entire set of rows
           done <= 1'b1;
        end
      end
      else begin //business as usual, read outside in
        if(x1<x2)begin //if we have fully iterated the current row, then reset the indices back to the outside
           x1 <= x1+1;
           x2 <= x2-1;
        end
        else begin
          y  <= y+1;
          x1 <= y*320;
          x2 <= x1+319;   
        end
        addr_r1 <= x1;
        addr_r2 <= x2; 
      end
      if(state==0) begin //if we are in the write state
         addr_w1 <= x1;
         addr_w2 <= x2;

         data_w1[7:0]   <= 255 - data_r2  [7:0];
         data_w1[15:8]  <= 255 - data_r2  [15:8];
         data_w1[23:16] <= 255 - data_r2  [23:16]; 

         data_w2 [7:0]   <= 255 - data_r1 [7:0];
         data_w2 [15:8]  <= 255 - data_r1 [15:8];
         data_w2 [23:16] <= 255 - data_r1 [23:16];
      end
    end
  fsm  fsm (
  .clk(clk),
  .reset_n(reset_n),

        .en_w1_n(en_w1_n),
        .en_r1_n(en_r1_n),
        .en_w2_n(en_w2_n),
        .en_r2_n(en_r2_n),

  .state(state)
  );

  DW_ram_2r_2w_s_dff  #(32,17) mem ( 
        .clk(clk),
        .rst_n(reset_n),

        //.en_w1_n(en_w1_n),
        .en_w1_n(1'b1),
        .addr_w1(addr_w1),
        .data_w1(data_w1),

        //.en_w2_n(en_w2_n),
        .en_w2_n(1'b1),
        .addr_w2(addr_w2),
        .data_w2(data_w2),

        .en_r1_n(en_r1_n),
        .addr_r1(addr_r1),
        .data_r1(data_r1),

        .en_r2_n(en_r2_n),
        .addr_r2(addr_r2),
        .data_r2(data_r2)
  ); 

// if(state==2'b10)
//   $display("hello")
  //write data = new inverted and flipped

  // // You can create your own sdram ..
  // mem memory_inst ( );

endmodule
//----------------------------------------------------------------------------------------
module fsm (clk, reset_n,
  en_w1_n, en_r1_n, en_w2_n, en_r2_n,
  state);

  input clk; // clock signal
  input reset_n; // reset input
  output reg en_w1_n, en_r1_n, en_w2_n, en_r2_n;  //enables
  reg [1:0] s; //placeholder state variable

  output reg [1:0] state;

  parameter     
    Start=0,  // "Extra" State
    Read=1,   // "Read" State
    Write=2;  // "Write" State

  // sequential memory of the Moore FSM
  always @(posedge clk, negedge reset_n) // active low for reset n
  begin
    if(!reset_n)  begin
      en_r1_n <= 0;
      en_r2_n <= 0;
      en_w1_n <= 0;
      en_w2_n <= 0;
      s <= Start;// when reset=1, reset the state of the FSM to "Zero" State
   end
    else
    case(s) // active low  aka 1 is off 0 is on
    Start:begin //turn everything off
      s<=Read;
      en_r1_n <= 1'b1;
      en_r2_n <= 1'b1;
      en_w1_n <= 1'b1;
      en_w2_n <= 1'b1;
    end   
    Read:begin // turn writes off and reads on
      s<=Write;
      en_r1_n <= 1'b0;
      en_r2_n <= 1'b0;
      en_w1_n <= 1'b1;
      en_w2_n <= 1'b1;   
    end
    Write:begin  // turn writes on and reads off
      s<=Start;
      en_r1_n <= 1'b1;
      en_r2_n <= 1'b1;     
      en_w1_n <= 1'b0;
      en_w2_n <= 1'b0;
    end
    endcase
  end
  assign state = s; //state output
endmodule
