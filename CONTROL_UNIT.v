module CONTROL_UNIT  (
input  wire  [5:0]   opcode,
input  wire  [5:0]   FUNCT,
input  wire          zero,
output wire          pcsr,
output wire          jump,
output wire          MemtoReg,
output wire          MemWrite,
output wire          Branch,
output wire          ALUSrc,
output wire          RegDst,
output wire          RegWrite,
output wire  [2:0]   ALU_CONTROL 
);
  
  
  
  wire    [1:0]        ALU_OP_wire;
  
  MAIN_DECODER MAIN_DECODER_i(
  .opcode(opcode),
  .jump(jump),
  .MemtoReg(MemtoReg),
  .MemWrite(MemWrite),
  .Branch(Branch),
  .ALUSrc(ALUSrc),
  .RegDst(RegDst),
  .RegWrite(RegWrite),
  .ALUOP(ALU_OP_wire),
  .zero(zero),
  .pcsr(pcsr)
  );
  
   
  ALU_DECODER ALU_DECODER_i(
  .ALU_OP(ALU_OP_wire),
  .FUNCT(FUNCT),
  .ALU_CONTROL(ALU_CONTROL)
  );


endmodule

