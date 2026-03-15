`timescale 1ns / 1ps
module MUX9 #(
      parameter width = 32
) (
      input CAUSE_SEL,
      output reg [width-1:0] out
);
      always @(*) begin
            case (CAUSE_SEL)
                  1'b0: out = {width{1'b0}};
                  1'b1: out = {{(width-1){1'b0}}, 1'b1};
            endcase
      end
endmodule