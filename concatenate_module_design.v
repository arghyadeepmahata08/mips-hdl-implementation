module concatenate_module_design(
    CIN26, CIN4, OUT
    );
    output reg [31:0] OUT;
    input [25:0] CIN26;
    input [3:0] CIN4;
    
    always @(*) begin
        OUT[1:0]   = 2'b00;
        OUT[27:2]  = CIN26;
        OUT[31:28] = CIN4;
    end
endmodule