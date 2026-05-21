module ALU #(parameter WIDTH=32) 
(
input  wire  [WIDTH-1:0]  scrA,
input  wire  [WIDTH-1:0]  scrB,
input  wire  [2:0]        ALU_Control,
output wire               zero_flag,
output reg   [WIDTH-1:0]  ALU_RESULT
);

always @(*) begin
    case(ALU_Control)
        3'b000: ALU_RESULT = scrA & scrB;
        3'b001: ALU_RESULT = scrA | scrB;
        3'b010: ALU_RESULT = scrA + scrB;
        3'b100: ALU_RESULT = scrA - scrB;

        3'b101: ALU_RESULT = scrA * scrB;

        // SLT 
        3'b110: ALU_RESULT = ($signed(scrA) < $signed(scrB)) ? 
                             {{(WIDTH-1){1'b0}},1'b1} : {WIDTH{1'b0}};

        default: ALU_RESULT = {WIDTH{1'b0}};
    endcase
end

assign zero_flag = (ALU_RESULT == {WIDTH{1'b0}});

endmodule