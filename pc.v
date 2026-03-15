// MIPS ARCHITECHTURE : Module Program counter: Group 7(AlgoVerse)


`timescale 1ns/1ns

module pc (Dout, RST_n, CLK, Din, LD);


    // Port declaration

    output reg [31:0] Dout;

    input  [31:0] Din;

    input  RST_n, CLK, LD;


    // Always block for sequential logic

    always @(posedge CLK or negedge RST_n) begin

        if (!RST_n) 

            Dout <= 32'b0;          // Reset has top priority

        else if (LD) 

            Dout <= Din;            // Update only when LD is set

        else 

            Dout <= Dout;           // Hold value

    end


endmodule
