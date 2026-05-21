module INSTRUCTION_MEMORY 
#(
    parameter WIDTH = 32,
    parameter DEPTH = 256
)
(
    input  wire [WIDTH-1:0] A,
    output wire [WIDTH-1:0] instr
);

reg [WIDTH-1:0] ROM [0:DEPTH-1];

initial begin
    ROM[0] = 32'h20080005;
    ROM[1] = 32'h2009000A;
    ROM[2] = 32'h01095020;
    ROM[3] = 32'h01485822;
end

assign instr = ROM[A >> 2];

endmodule