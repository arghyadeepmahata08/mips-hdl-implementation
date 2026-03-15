`timescale 1ns / 1ps
module MUX10 #(
      parameter width = 32
) (
      input [width-1:0] ALUout,
      input [width-1:0] ALUReg,
      input [width-1:0] Reg1,
      input [width-1:0] PC,
      input [25:0] Inst_index,
      input [2:0] PC_SEL,
      output reg [width-1:0] out
);
      always @(*) begin
            case (PC_SEL)
                  3'b000: out = ALUout;
                  3'b001: out = ALUReg;
                  3'b010: out = {PC[width-1:28], Inst_index, 2'b00};
                  3'b011: out = Reg1;
                  3'b100: out = 32'h0;
                  3'b101: out = {width{1'b0}};
                  3'b110: out = {width{1'b0}};
                  3'b111: out = {width{1'b0}};
            endcase
      end
endmodule