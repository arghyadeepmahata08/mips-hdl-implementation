module MUX #(parameter WIDTH = 32)
(
input  wire  [WIDTH-1:0] IN1,
input  wire  [WIDTH-1:0] IN2,
input  wire              sel,
output wire [WIDTH-1:0] OUT
);

assign OUT = sel ? IN2 : IN1;

endmodule