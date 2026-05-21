module ALU_DECODER (
input  wire  [1:0]        ALU_OP,
input  wire  [5:0]        FUNCT,
output reg   [2:0]        ALU_CONTROL 
);

 always @(*) begin
     case(ALU_OP)

       2'b00: ALU_CONTROL = 3'b010; // ADD (lw, sw)

       2'b01: ALU_CONTROL = 3'b100; // SUB (beq)

       2'b10: begin
         case(FUNCT)
           6'b100000: ALU_CONTROL = 3'b010; // ADD
           6'b100010: ALU_CONTROL = 3'b100; // SUB
           6'b100100: ALU_CONTROL = 3'b000; // AND
           6'b100101: ALU_CONTROL = 3'b001; // OR
           6'b101010: ALU_CONTROL = 3'b110; // SLT
           default:   ALU_CONTROL = 3'b010;
         endcase
       end

       default: ALU_CONTROL = 3'b010;

     endcase     
 end

endmodule