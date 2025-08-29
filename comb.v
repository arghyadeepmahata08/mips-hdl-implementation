`timescale 1 ns / 1 ps

module comb(NF, ZF, BLTZ,BGTZ,BLEZ,BNE,BEQ,PC_EN,OUT);
    //Port declaration
    output OUT;
    input NF, ZF, BLTZ,BGTZ,BLEZ,BNE,BEQ,PC_EN;

    //Integral variable declarations
    reg OUT;

    //Behavioaral model of the Combinational Block Circuit
    always @(NF, ZF, BLTZ,BGTZ,BLEZ,BNE,BEQ,PC_EN) begin
        OUT = (NF & BLTZ) | (BGTZ & ~(NF | ZF)) | (BLEZ & (NF | ZF)) | (~ZF & BNE) | (ZF & BEQ) | PC_EN;
    end

endmodule