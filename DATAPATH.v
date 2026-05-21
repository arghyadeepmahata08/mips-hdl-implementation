module DATA_PATH #(parameter WIDTH=32)
( 
  output wire     [15:0]    test_value_wire,
  output wire     [5:0]     istr_opcode_wire,
  output wire     [5:0]     istr_FUNCT_wire,
  input  wire     [2:0]     alu_control_wire,
  input  wire               clk_wire,
  input  wire               rst_wire,
  input  wire               REG_write_wire,
  input  wire               MEM_write_wire,
  input  wire               REG_DST_wire,
  input  wire               ALU_SRC_wire,
  input  wire               MemtoReg_wire,
  input  wire               Branch_wire,
  input  wire               jump_wire,
  input  wire               pcsr,
  output wire               zero_wire
);

 // ================= WIRES =================
 wire [WIDTH-1:0] instr;

 wire [WIDTH-1:0] scrB_MUX1_wire;
 wire [WIDTH-1:0] scrA_RD1_wire;
 wire [WIDTH-1:0] alu_result_wire;
 wire [WIDTH-1:0] RD_DATA_wire;
 wire [WIDTH-1:0] PC_plus4_wire;
 wire [WIDTH-1:0] PC_out_wire;
 wire [WIDTH-1:0] RD2_wire;
 wire [WIDTH-1:0] signimm_wire;
 wire [WIDTH-1:0] WD3_wire;
 wire [WIDTH-1:0] branch_shift_wire;
 wire [WIDTH-1:0] branch_target_wire;
 wire [WIDTH-1:0] pc_next_wire;
 wire [WIDTH-1:0] pc_branch_mux_wire;

 wire [27:0] jump_shift_wire;

 wire [4:0] A3_wire;

 // PC
 PC #(.WIDTH(WIDTH)) pc_i 
 (
  .pc_input(pc_next_wire),
  .clk(clk_wire),
  .rst(rst_wire),
  .pc_output(PC_out_wire)
 );

 // INSTRUCTION MEMORY
 INSTRUCTION_MEMORY #(.WIDTH(WIDTH)) instr_mem_i 
 (
  .A(PC_out_wire),
  .instr(instr)
 );

 // DECODER FIELDS
 assign istr_opcode_wire = instr[31:26];
 assign istr_FUNCT_wire  = instr[5:0];

 // REGISTER FILE
 REGISTER_FILE #(.WIDTH(WIDTH)) regfile_i 
 (
  .RD1(scrA_RD1_wire),
  .RD2(RD2_wire),
  .clk(clk_wire),
  .rst(rst_wire),
  .WE3(REG_write_wire),
  .A1(instr[25:21]),   // rs
  .A2(instr[20:16]),   // rt
  .A3(A3_wire),
  .WD3(WD3_wire)
 );

 // DATA MEMORY
 DATA_MEMORY #(.WIDTH(WIDTH)) data_mem_i 
 (
  .RD(RD_DATA_wire),
  .WE(MEM_write_wire),
  .clk(clk_wire),
  .rst(rst_wire),
  .A(alu_result_wire),
  .WD(RD2_wire),
  .test_value(test_value_wire)
 );

 // ALU
 ALU #(.WIDTH(WIDTH)) alu_i 
 (
  .scrA(scrA_RD1_wire),
  .scrB(scrB_MUX1_wire),
  .ALU_Control(alu_control_wire),
  .zero_flag(zero_wire),
  .ALU_RESULT(alu_result_wire)
 );

 //SIGN EXTEND
 SIGN_EXTEND #(.WIDTH(WIDTH)) signext_i 
 (
  .instr(instr[15:0]),
  .Sign_IMM(signimm_wire)
 );

 // SHIFT LEFT TWICE
 SHIFT_LEFT_TWICE #(.WIDTH(WIDTH)) shift_branch_i 
 (
  .in(signimm_wire),
  .out(branch_shift_wire)
 );

 // JUMP SHIFT
 assign jump_shift_wire = instr[25:0] << 2;

 // ADDER
 ADDER #(.WIDTH(WIDTH)) adder_pc4_i 
 (
  .A(PC_out_wire),
  .B(32'd4),
  .C(PC_plus4_wire)
 );
 
 ADDER #(.WIDTH(WIDTH)) adder_branch_i 
 (
  .A(PC_plus4_wire),
  .B(branch_shift_wire),
  .C(branch_target_wire)
 );

 // MUX

 // RegDst
 MUX #(.WIDTH(5)) mux_regdst 
 (
  .IN1(instr[20:16]),
  .IN2(instr[15:11]),
  .OUT(A3_wire),
  .sel(REG_DST_wire)
 );

 // ALUSrc
 MUX #(.WIDTH(WIDTH)) mux_alusrc 
 (
  .IN1(RD2_wire),
  .IN2(signimm_wire),
  .OUT(scrB_MUX1_wire),
  .sel(ALU_SRC_wire)
 );

 // MemtoReg
 MUX #(.WIDTH(WIDTH)) mux_memtoreg
 (
  .IN1(alu_result_wire),
  .IN2(RD_DATA_wire),
  .OUT(WD3_wire),
  .sel(MemtoReg_wire)
 );

 // Branch mux
 MUX #(.WIDTH(WIDTH)) mux_branch
 (
  .IN1(PC_plus4_wire),
  .IN2(branch_target_wire),
  .OUT(pc_branch_mux_wire),
  .sel(pcsr)
 );

 // Jump mux
 MUX #(.WIDTH(WIDTH)) mux_jump
 (
  .IN1(pc_branch_mux_wire),
  .IN2({PC_plus4_wire[31:28], jump_shift_wire}),
  .OUT(pc_next_wire),
  .sel(jump_wire)
 );

endmodule