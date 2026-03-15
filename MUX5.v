`timescale 1ns / 1ps
module MUX5 #(
      parameter width = 32
) (
      input [width-1:0] ALU,
      input [width-1:0] IR,
      input [width-1:0] EPC,
      input [width-1:0] CR,
      input [width-1:0] MUX3_out,
      input [width-1:0] PC,
      input [2:0] MEMtoREG,
      output reg [width-1:0] out
);
      always @(*) begin
            case (MEMtoREG)
                  3'b000: out = ALU;
                  3'b001: out = IR;
                  3'b010: out = EPC;
                  3'b011: out = CR;
                  3'b100: out = MUX3_out;
                  3'b101: out = PC;
                  3'b110: out = {width{1'b0}};
                  3'b111: out = {width{1'b0}};
            endcase
      end
endmodule