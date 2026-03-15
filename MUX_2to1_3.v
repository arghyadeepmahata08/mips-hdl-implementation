`timescale 1ns / 1ps
module MUX7 #(
      parameter width = 32
) (
      input [width-1:0] PC,
      input [width-1:0] Reg1,
      input ALU_SEL1,
      output reg [width-1:0] out
);
      always @(*) begin
            case (ALU_SEL1)
                  1'b0: out = PC;
                  1'b1: out = Reg1;
                  default: out = {width{1'b0}};
            endcase
      end
endmodule