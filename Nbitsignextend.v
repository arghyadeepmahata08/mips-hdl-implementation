/*
Group Silveda (23EC8089 to 23EC8096)
Module : Sign Extension (N-bit to 32-bit)
*/

`timescale 1 ns/1 ns

module bitsignextend_N #(parameter N=16)(in,out);

//Port declaration
	input [N-1:0]in;
	output [31:0]out;

//Internal variable declarations
	reg [31:0]out;

//Model of 16 bit sign extender
	always @(in) begin	//Trigerred off input change
		out[N-1:0]=in[N-1:0];	//The N bits of input remain the same in the output's last N bits
		out[31:N]={(32-N){in[N-1]}};	//Sign extension of the remaining 32-N bits
	end

endmodule
