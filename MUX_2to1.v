`timescale 1ns / 1ps
module MUX1 #(
      parameter width = 32
) (
      input [width-1 : 0] PC,
      input [width-1 : 0] ALU,
      input IorD,
      output reg [width-1 : 0] out
);
      always @(*) begin
            case (IorD)
                  1'b0: out = PC;
                  1'b1: out = ALU;
            endcase
      end
endmodule