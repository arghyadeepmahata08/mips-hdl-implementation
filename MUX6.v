`timescale 1ns / 1ps
module MUX6 #(
      parameter width = 32
) (
      input [15:0] ImmData,
      input SIGNEXT_SEL,
      output reg [width-1:0] out
);
      always @(*) begin
            case (SIGNEXT_SEL)
                  1'b0: out = {{16{ImmData[15]}}, ImmData};
                  1'b1: out = {{16{1'b0}}, ImmData};
            endcase
      end
endmodule