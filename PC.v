module PC #(parameter WIDTH=32) 
(
input  wire  [WIDTH-1:0]  pc_input,
input  wire               clk,
input  wire               rst,
output reg   [WIDTH-1:0]  pc_output 
);

 always @(posedge clk)
  begin
    if (rst)
      pc_output <= {WIDTH{1'b0}};
    else
      pc_output <= pc_input;
  end
  
endmodule