`timescale 1ns / 1ps
module MUX3 #(
      parameter width = 32
) (
      input [width-1:0] IR,
      input [2:0] REG_SEL_DATA,
      output reg [width-1:0] out
);
      always @(*) begin
            case (REG_SEL_DATA)
                  3'b000: out = IR;
                  3'b001: out = {{24{1'b0}}, {IR[7:0]}};
                  3'b010: out = {{24{IR[7]}}, {IR[7:0]}};
                  3'b011: out = {{16{1'b0}}, {IR[15:0]}};
                  3'b100: out = {{16{IR[15]}}, {IR{15:0}}};
                  3'b101: out = {width{1'b0}};
                  3'b110: out = {width{1'b0}};
                  3'b111: out = {width{1'b0}};
            endcase
      end
endmodule