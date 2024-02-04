`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2024 03:02:17 PM
// Design Name: 
// Module Name: CAM_testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CAM_testbench();
    
    parameter DATA_WIDTH = 21;
    parameter ADDR_WIDTH = 6;
    parameter PATH = "CAM.txt";
    
    reg clk, rst_n;
    reg       we;
    reg [DATA_WIDTH - 2 : 0]  pattern;
    reg [ADDR_WIDTH - 1 : 0]  wr_addr;
    wire [ADDR_WIDTH - 1 : 0] maddr;
    wire                      mfound;
    
    CAM #(
            .DATA_WIDTH(DATA_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH),
            .PATH(PATH)
        )
        cam
        (
            .clk(clk), 
            .rst_n(rst_n),
            .we(we),
            .pattern(pattern),
            .wr_addr(wr_addr),    
            .maddr(maddr),      
            .mfound(mfound)
        );
        
    always #10 clk = ~clk;
    
    integer i;
    initial begin
    
        {clk, rst_n, we, pattern, wr_addr} = 0;
        #5
        rst_n = 1;
        for(i = 0; i < 2 ** ADDR_WIDTH ; i = i + 1) begin
            #20 pattern = i;
        end
    
    end
    
endmodule
