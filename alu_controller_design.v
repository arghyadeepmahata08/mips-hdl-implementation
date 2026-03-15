`timescale 1ns / 1ps

module alu_controller_design(FUNCT, CNRL, OUT);

input [5:0] FUNCT;
input [2:0] CNRL;
output [3:0] OUT;

reg [3:0] OUT;

always @(FUNCT, CNRL)
 begin
     case(CNRL)
     3'b000:OUT=4'b0010;
     3'b001:OUT=4'b0110;
     3'b010:            //R-type
         case(FUNCT)
         6'b001001:OUT=4'b0010;// alu add
         6'b100000:OUT=4'b0010;
         6'b100001:OUT=4'b0010;
         6'b100010:OUT=4'b0110;//alu sub
         6'b100011:OUT=4'b0110;
         6'b100100:OUT=4'b0000;//alu and
         6'b100101:OUT=4'b0001;// alu or
         6'b100110:OUT=4'b0011;//alu xor
         6'b100111:OUT=4'b0100;//alu nor
         6'b000000:OUT=4'b1000;// alu sll
         6'b000100:OUT=4'b1001;//alu sllv
         6'b000010:OUT=4'b1010;//alu srl
         6'b000110:OUT=4'b1011;//alu srlv
         6'b000011:OUT=4'b1100;//alu sra
         6'b000111:OUT=4'b1101;//alu srav
         6'b101001:OUT=4'b1010;//alu sltu
         6'b101010:OUT=4'b0111;//alu slt
         default:OUT=4'bxxxx;
         endcase
     3'b011:OUT=4'b0111;
     3'b100:OUT=4'b0000;
     3'b101:OUT=4'b0001;
     3'b110:OUT=4'b0011;
     default:OUT=4'bxxxx;    
     endcase
 end  
         
     
endmodule
