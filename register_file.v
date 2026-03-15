`timescale 1ns/1ns
module reg_file(Reg1_data, Reg2_data, Reg1, Reg2, Write_Reg, Write_Data, OE, WS);
    output reg [31:0] Reg1_data;   //data being read out of Reg1 port
    output reg [31:0] Reg2_data;   //data being read out of Reg2 port
    input [4:0] Reg1;          //Reg1 address
    input [4:0] Reg2;          //Reg2 address
    input [4:0] Write_Reg;     //address of write register
    input [31:0] Write_Data;   //write register data
    input OE, WS;              //OE = read enable, WS = write enable
    reg [31:0] mem [0:31];     //32x32 register file

    // Initialize Register File from file at simulation start
    initial begin
        $readmemh("RegFile_Data.mem", mem); // Load register file data from file
    end

    always@(OE, Reg1, Reg2) begin   //asynchronous read
        if (OE) begin               
            Reg1_data = mem[Reg1];
            Reg2_data = mem[Reg2];
        end else begin
            Reg1_data = Reg1_data;
            Reg2_data = Reg2_data;
        end
    end

    always@(posedge WS) begin
        mem[Write_Reg] <= Write_Data;   //write to location specified by Write_Reg
    end
endmodule