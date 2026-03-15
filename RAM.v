`timescale 1ns/1ns
module RAM(DataOut, Addr, WriteData, OE, WS);

//Port declaration
output [31:0] DataOut;      //data being read out of RAM
input  [31:0] WriteData;    //data being written to RAM
input  [7:0]  Addr;         //RAM address
input  OE, WS;              //OE = read enable, WS = write enable

//Internal wire declaration
reg [31:0] mem [0:255];     //256x32 memory block
reg [31:0] DataOut;         //used for data output

always @(OE, Addr) begin    //asynchronous read
    if (OE)                 //active high OE
        DataOut = mem[Addr];    //word at location Addr goes to output
    else
        DataOut = DataOut;      //output stays the same if OE not enabled
end

always @(posedge WS)        //write routine. creates flip-flops. Active high WS.
begin
    mem[Addr] <= WriteData; //word written at location Addr
end

endmodule
