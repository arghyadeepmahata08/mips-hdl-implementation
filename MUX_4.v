`timescale 1ns / 1ps
module MUX4 (
      input [4:0] rt,
      input [4:0] rd,
      input [1:0] Reg_Dest,
      output reg [4:0] out
);
      always @(*) begin
            case (Reg_Dest)
                  2'b00: out = rt;
                  2'b01: out = rd;
                  2'b10: out = 5'b11111;
                  2'b11: out = 5'bzzzzz;
            endcase
      end
endmodule