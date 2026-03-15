`timescale 1ns / 1ps
module MUX8 #(
      parameter width = 32
) (
      input [width-1:0] Reg2,
      input [width-1:0] MUX6_data, 
      input [2:0] ALU_SEL_2,
      output reg [width-1:0] out
);
      always @(*) begin
            case (ALU_SEL_2)
                  3'b000: out = Reg2;
                  3'b001: out = 32'h1;
                  3'b010: out = MUX6_data;
                  3'b011: out = MUX6_data << 2;
                  3'b100: out = 32'h0;
                  3'b101: out = {width{1'b0}};
                  3'b110: out = {width{1'b0}};
                  3'b111: out = {width{1'b0}};
            endcase
      end
endmodule