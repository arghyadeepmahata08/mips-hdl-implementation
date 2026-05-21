module DATA_MEMORY #(parameter WIDTH=32, DEPTH=32) 
(
output reg  [WIDTH-1:0]    RD,
input  wire                clk,
input  wire                rst,
input  wire                WE, 
input  wire [WIDTH-1:0]    A,
input  wire [WIDTH-1:0]    WD,
output reg  [15:0]         test_value 
);

 reg [WIDTH-1:0] Data_memory [0:DEPTH-1];
 integer i; 

 // Write + Reset
 always @(posedge clk or negedge rst)
 begin
     if(!rst)
     begin
         for(i = 0; i < DEPTH; i = i + 1)
             Data_memory[i] <= 32'b0;
     end
     else if(WE)
     begin
         Data_memory[A[31:2]] <= WD;
     end
 end

 // Read
 always @(*)
 begin
     RD = Data_memory[A[31:2]];
 end

 // Debug output
 always @(*)
 begin
     test_value = Data_memory[0][15:0];
 end

endmodule