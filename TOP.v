module TOP  #(parameter WIDTH=32)
(
  input  wire               clk_wire,
  input  wire               rst_wire,
  output wire     [15:0]    test_value
 );
  
 wire  [5:0]   opcode;
 wire  [5:0]   FUNCT;
 wire          zero;
 wire          pcsr;
 wire          jump;
 wire          MemtoReg;
 wire          MemWrite;   // FIXED
 wire          Branch;
 wire          ALUSrc;
 wire          RegDst;
 wire          RegWrite;
 wire  [2:0]   ALU_CONTROL;  
  
CONTROL_UNIT CONTROL_UNIT_i (
  .opcode(opcode),
  .FUNCT(FUNCT),
  .zero(zero),
  .pcsr(pcsr),
  .jump(jump),
  .MemtoReg(MemtoReg),
  .MemWrite(MemWrite),   // FIXED
  .RegWrite(RegWrite),
  .Branch(Branch),
  .ALUSrc(ALUSrc),
  .RegDst(RegDst),
  .ALU_CONTROL(ALU_CONTROL)
);

DATA_PATH #(.WIDTH(WIDTH)) DATA_PATH_i 
 (
  .clk_wire(clk_wire),
  .rst_wire(rst_wire),
  .alu_control_wire(ALU_CONTROL),
  .REG_write_wire(RegWrite),
  .MEM_write_wire(MemWrite),  // FIXED
  .REG_DST_wire(RegDst),
  .ALU_SRC_wire(ALUSrc),
  .MemtoReg_wire(MemtoReg),
  .Branch_wire(Branch),
  .jump_wire(jump),
  .test_value_wire(test_value),
  .istr_opcode_wire(opcode),
  .istr_FUNCT_wire(FUNCT),
  .pcsr(pcsr),
  .zero_wire(zero)
 );
 
endmodule