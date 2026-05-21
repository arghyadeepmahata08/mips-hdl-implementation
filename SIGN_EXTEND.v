module SIGN_EXTEND #(parameter WIDTH =32)
(
input  wire  [(WIDTH/2)-1:0]       instr,
output reg   [WIDTH-1:0]           Sign_IMM 
);

 always @(*)
  begin

    Sign_IMM[15:0]=instr;
Sign_IMM = {{(WIDTH/2){instr[(WIDTH/2)-1]}}, instr};                           
  end
endmodule


