module REGISTER_FILE #(parameter WIDTH=32 , parameter WIDTH_2=5) 
(
output wire [WIDTH-1:0] RD1,
output wire [WIDTH-1:0] RD2,
input  wire             clk,
input  wire             rst,
input  wire             WE3, 
input  wire [WIDTH_2-1:0] A1,
input  wire [WIDTH_2-1:0] A2,
input  wire [WIDTH_2-1:0] A3,
input  wire [WIDTH-1:0]   WD3
);

reg [WIDTH-1:0] register_file [0:31];
integer i;

// Write and Reset
always @(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        for(i=0;i<32;i=i+1)
            register_file[i] <= 0;
    end
    else if(WE3 && A3 != 0)
    begin
        register_file[A3] <= WD3;
    end
end

// Read with forwarding
assign RD1 = (WE3 && (A1 == A3)) ? WD3 : register_file[A1];
assign RD2 = (WE3 && (A2 == A3)) ? WD3 : register_file[A2];

endmodule