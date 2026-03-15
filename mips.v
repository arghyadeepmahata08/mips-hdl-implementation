`timescale 1ns/1ns

module mips(input CLK, input RST_n,
 // Primary outputs
    output wire [31:0] PC_OUT,
    output wire [31:0] Inst,
    output wire [31:0] ALU_OUT,
//    output wire [31:0] DATA_WIRE,
    output wire [2:0] NSTATE,
    
    // Control signals outputs
    output wire ZF_OUT, 
//    output wire PC_EN, IorD, MEM_OE, MEM_WS, IR_EN, REG_OE, REG_WS, 
//    output wire SIGNEXT_SEL, ALU_SEL1, EPC_EN, CAUSE_SEL, CAUSE_EN,
//    output wire PCWrite_BEQ, PCWrite_BNE, PCWrite_BGTZ, PCWrite_BLTZ, PCWrite_BLEZ, PC_LOAD,
    
    // Multi-bit control signals
//    output wire [2:0] present_state, next_state, PC_SEL, REG_DATA_SEL, ALU_SEL2, ALU_OP, MEMtoREG,
//    output wire [1:0] MEM_DATA_SEL, Reg_Dest,
//    output wire [3:0] ALU_CONTROL,
    
    // Data path outputs
//    output wire [31:0] PC_SEL_WIRE, ALU_REG_OUT, Addr, DATA, WriteData,
   output wire [31:0] Reg_Write_Data);
//    output wire [31:0] Reg1_Data, Reg2_Data, Immediate_Out, Reg1_Out,
//    output wire [31:0] ALU_OP1, ALU_OP2, CAUSE_DATA, CAT_OUT,
//    output wire [4:0] Dest_Addr);
//Port declaration
//input CLK, RST_n;

//Internal port declaration

wire OF_OUT, BF_OUT, NF_OUT, ZF_OUT, PC_EN, IorD, MEM_OE, MEM_WS, IR_EN, REG_OE, REG_WS, SIGNEXT_SEL, ALU_SEL1, EPC_EN, CAUSE_SEL, CAUSE_EN, PCWrite_BEQ, PCWrite_BNE, PCWrite_BGTZ, PCWrite_BLTZ, PCWrite_BLEZ, PC_LOAD;
wire [2:0] present_state, next_state, PC_SEL, REG_DATA_SEL, ALU_SEL2, ALU_OP, MEMtoREG;
wire [1:0] MEM_DATA_SEL, Reg_Dest;
wire [31:0] Inst, PC_OUT, PC_SEL_WIRE, ALU_REG_OUT, Addr, DATA, WriteData, Reg2_Out, EB1_Out, EW1_Out, EB21_Out, EB2_Out, EW21_Out, EW2_Out, DATA_WIRE, EPC_OUT, CAUSE_OUT, Reg_Write_Data, Reg1_Data, Reg2_Data, EW3_Out, EW22_Out, Immediate_Out, Immediate_SL, Reg1_Out, ALU_OP1, ALU_OP2, ALU_OUT, CAUSE_DATA, Inst_SL, CAT_OUT, NC;
wire [4:0] Dest_Addr;
wire [5:0] STATE;
wire [3:0] ALU_CONTROL;

// The netlist

control CTL(.Opcode(Inst[31:26]), .Present_State(present_state), .OF(OF_OUT), .BF(BF_OUT), .Funct(Inst[5:0]), .Rd(Inst[15:11]), .Next_State(next_state), .PC_EN(PC_EN), .PC_SEL(PC_SEL), .IorD(IorD), .MEM_DATA_SEL(MEM_DATA_SEL), .MEM_OE(MEM_OE), .MEM_WS(MEM_WS), .REG_DATA_SEL(REG_DATA_SEL), .IR_EN(IR_EN), .Reg_Dest(Reg_Dest), .MEMtoREG(MEMtoREG), .REG_OE(REG_OE),.REG_WS(REG_WS), .SIGNEXT_SEL(SIGNEXT_SEL), .ALU_SEL1(ALU_SEL1), .ALU_SEL2(ALU_SEL2), .ALU_OP(ALU_OP), .EPC_EN(EPC_EN), .CAUSE_SEL(CAUSE_SEL), .CAUSE_EN(CAUSE_EN), .PCWrite_BEQ(PCWrite_BEQ), .PCWrite_BNE(PCWrite_BNE), .PCWrite_BGTZ(PCWrite_BGTZ), .PCWrite_BLTZ(PCWrite_BLTZ), .PCWrite_BLEZ(PCWrite_BLEZ), .STATE(STATE)); //Sequence Controller

StateReg SRG(present_state[2:0], next_state[2:0], CLK, RST_n); //Phase Generator

assign NSTATE = present_state;
comb CMB(NF_OUT, ZF_OUT, PCWrite_BLTZ, PCWrite_BGTZ, PCWrite_BLEZ, PCWrite_BNE, PCWrite_BEQ, PC_EN, PC_LOAD); //Combinational Block

pc PCR(PC_OUT[31:0], RST_n, CLK, PC_SEL_WIRE[31:0], PC_LOAD); //Program Counter

MUX1 mux1(PC_OUT[31:0], ALU_REG_OUT[31:0], IorD, Addr[31:0]); //Mux 1. Selects RAM address source.

RAM MEM1(DATA[31:0], Addr[7:0], WriteData[31:0], MEM_OE, MEM_WS); //RAM module. Most significant 26 bits of Addr not used to conserve resources.

 MUX2 mux2(Reg2_Out[31:0], MEM_DATA_SEL[1:0], WriteData[31:0]); //Mux2. Input D is a No Connect (NC). Selects RAM data source.
 
 MUX3 mux3(DATA[31:0],REG_DATA_SEL,DATA_WIRE);
 
 scale_reg_en MIR(DATA_WIRE,IR_EN,CLK,Inst);
 
 MUX4 mux4(Inst[20:16], Inst[15:11],Reg_Dest,Dest_Addr);
 
 MUX5 mux5(ALU_OUT[31:0], Inst[31:0], EPC_OUT[31:0], CAUSE_OUT[31:0], DATA_WIRE[31:0], PC_OUT[31:0], MEMtoREG[2:0], Reg_Write_Data[31:0]); //Mux5. Selects Register File data source.

reg_file MEM2(Reg1_Data[31:0], Reg2_Data[31:0],Inst[25:21], Inst[20:16], Dest_Addr[4:0], Reg_Write_Data[31:0], REG_OE, REG_WS); //Register File

MUX6 mux6(Inst[15:0], SIGNEXT_SEL, Immediate_Out[31:0]); //Mux 6. Selects Immediate value to be used by the ALU.

//shift_left2 SIL1(Immediate_Out[31:0], Immediate_SL[31:0]); //Shift Immediate value left by two bits. Input listed first.

scale_reg_en #(32)REG1(Reg1_Data[31:0],1'b1 , CLK, Reg1_Out[31:0]); //ALU Reg1. Input listed first.

scale_reg_en #(32)REG2(Reg2_Data[31:0],1'b1 , CLK, Reg2_Out[31:0]); //ALU Reg2. Input listed first.

MUX7 mux7(PC_OUT[31:0], Reg1_Out[31:0], ALU_SEL1, ALU_OP1[31:0]); //Mux 7. Selects ALU Operand1 source.

MUX8 mux8(Reg2_Out[31:0], Immediate_Out[31:0], ALU_SEL2[2:0], ALU_OP2[31:0]); //Mux 8 Selects MIR data source.

ALU_CONTROLLER CONT(Inst[5:0], ALU_OP[2:0], ALU_CONTROL[3:0]); //ALU controller .Inputs listed first.

ALU alu(ALU_OP1[31:0], ALU_OP2[31:0], ALU_CONTROL[3:0], Inst[10:6], ALU_OUT[31:0], NF_OUT, ZF_OUT, OF_OUT, BF_OUT); //ALU. Inputs listed first.

ALU_Register alu_reg(ALU_OUT[31:0], CLK, ALU_REG_OUT[31:0]); //ALU Register. Inputs listed first.

MUX9 mux9( CAUSE_SEL, CAUSE_DATA[31:0]); //Mux 9. Determines content of Cuase register.

CAUSE cause(CAUSE_DATA[31:0], CAUSE_EN, CLK, CAUSE_OUT[31:0]); //Cause Register. Inputs listed first.

EPC epc(PC_OUT[31:0], EPC_EN, CLK, EPC_OUT[31:0]); //EPC Register. Inputs listed first.

Concatenate CAT(Inst[25:0], PC_OUT[31:28], CAT_OUT[31:0]); //concatenate to calculate PC address for Jump function

MUX10 mux10(ALU_OUT[31:0], ALU_REG_OUT[31:0],Reg1_Out[31:0], CAT_OUT[31:0], PC_SEL[2:0], PC_SEL_WIRE[31:0]); //Mux 10. Selects PC value.
 
 endmodule