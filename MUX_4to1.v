`timescale 1ns / 1ps
module MUX2 #(
      parameter width = 32
) (
      input [width-1:0] Reg2,
      input [1:0] MEM_DATA_SEL,
      output reg [width-1:0] out
);
      always @(*) begin
            case (MEM_DATA_SEL)
                  2'b00: out = Reg2;
                  2'b01: out = {{24{Reg2[7]}}, {Reg2[7:0]}};
                  2'b10: out = {{16{Reg2[15]}}, {Reg2[15:0]}};
                  2'b11: out = {width{1'b0}};
            endcase
      end
endmodule