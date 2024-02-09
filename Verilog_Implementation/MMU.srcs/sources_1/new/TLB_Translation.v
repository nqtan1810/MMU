`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2024 04:39:39 PM
// Design Name: 
// Module Name: TLB_Translation
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


module TLB_Translation
#(
    parameter DATA_WIDTH_CAM = 21,
    parameter DATA_WIDTH_RAM = 20,
    parameter ADDR_WIDTH = 6,
    parameter PATH_INIT_CAM = "CAM.txt",
    parameter PATH_INIT_RAM = "TLB_RAM.txt"
)
(
    clk,
    rst_n,
    tlb_en,
    tlb_trans_en,
    we,
    vpn_in,
    ppn_in,
    wr_addr,
    ppn_o,
    tlb_hit
);

    output [DATA_WIDTH_RAM - 1 : 0] ppn_o;
    output tlb_hit;
    
    input clk;
    input rst_n;
    input tlb_en;
    input tlb_trans_en;
    input we;
    input [DATA_WIDTH_CAM - 2 : 0] vpn_in;
    input [DATA_WIDTH_RAM - 1 : 0] ppn_in;
    input [ADDR_WIDTH - 1 : 0]     wr_addr;
    
    wire  en;
    wire  [ADDR_WIDTH - 1 : 0]     ram_addr;
    wire  [ADDR_WIDTH - 1 : 0]     maddr;
    
    CAM #(
            .DATA_WIDTH(DATA_WIDTH_CAM),
            .ADDR_WIDTH(ADDR_WIDTH),
            .PATH(PATH_INIT_CAM)
        )
        cam
        (
            .clk(clk), 
            .rst_n(rst_n),
            .en(en),
            .we(we),
            .pattern(vpn_in),
            .wr_addr(wr_addr),    
            .maddr(maddr),      
            .mfound(tlb_hit)
        );
    
    RAM #(
              .DATA_WIDTH(DATA_WIDTH_RAM),
              .ADDR_WIDTH(ADDR_WIDTH),
              .PATH(PATH_INIT_RAM)
          ) 
          tlb_ram 
          (
              .q(ppn_o),
              .clk(clk),
              .en(en),
              .we(we),
              .data(ppn_in),
              .addr(ram_addr)
          );
    
    assign en = tlb_en | tlb_trans_en;
    assign ram_addr = we ? wr_addr : maddr;

endmodule
