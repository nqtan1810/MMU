`timescale 1ns/1ps

module mmu_datapath_tb(

    );
    parameter VPN_WIDTH = 20;
    parameter DATA_WIDTH_L1 = 21;
    parameter DATA_WIDTH_L2 = 4;
    parameter ADDR_WIDTH_L1 = 10;
    parameter ADDR_WIDTH_L2 = 20;
    parameter PATH_INIT_L1 = "ram_L1_init.txt";
    parameter PATH_INIT_L2 = "ram_L2_init.txt";
    parameter EXCPT_WIDTH = 3;
    parameter PROTECTION_BITS_WIDTH = 4;
    
    parameter DATA_WIDTH_CAM = 22;
    parameter DATA_WIDTH_RAM = 20;
    parameter ADDR_WIDTH_TLB = 6;
    parameter PATH_INIT_CAM = "CAM.txt";
    parameter PATH_INIT_RAM = "TLB_RAM.txt";
    
    reg clk;
    reg rst_n;
    reg tlb_en;
    reg [DATA_WIDTH_CAM - 3 : 0] vpn_in;
    reg [DATA_WIDTH_RAM - 1 : 0] ppn_in;
    reg we_tlb;
    reg [1 : 0] we_mem_protection; 
    reg [(DATA_WIDTH_L1-1) : 0] protect_bit_data_write;
    reg instr_type;
    
    wire [DATA_WIDTH_RAM - 1 : 0] ppn_o;
    wire tlb_hit;
    wire [(EXCPT_WIDTH-1) : 0] exception;
    
    initial begin
    // reset
       #1 tlb_en = 1;
       {clk, rst_n, tlb_en, vpn_in, ppn_in, we_tlb, we_mem_protection, protect_bit_data_write, instr_type} = 0;
       #5
       
       {rst_n, tlb_en, instr_type} = 3'b111;
       vpn_in = 360448; 
       $display("%0d", mmu_datapath_tb.address_translation.tlb_translation.cam.maddr);
    end
    
    always #10 clk = ~clk;
    
    mmu_datapath
                #(
                    .VPN_WIDTH(VPN_WIDTH),
                    .DATA_WIDTH_L1(DATA_WIDTH_L1),
                    .DATA_WIDTH_L2(DATA_WIDTH_L2),
                    .ADDR_WIDTH_L1(ADDR_WIDTH_L1),
                    .ADDR_WIDTH_L2(ADDR_WIDTH_L2),
                    .PATH_INIT_L1(PATH_INIT_L1),
                    .PATH_INIT_L2(PATH_INIT_L2),
                    .EXCPT_WIDTH(EXCPT_WIDTH),
                    .PROTECTION_BITS_WIDTH(PROTECTION_BITS_WIDTH),
                    
                    .DATA_WIDTH_CAM(DATA_WIDTH_CAM),
                    .DATA_WIDTH_RAM(DATA_WIDTH_RAM),
                    .ADDR_WIDTH_TLB(ADDR_WIDTH_TLB),
                    .PATH_INIT_CAM(PATH_INIT_CAM),
                    .PATH_INIT_RAM(PATH_INIT_RAM)
                    
                )
                mmu_datapath_tb
                (
                    .clk(clk),
                    .rst_n(rst_n),
                    .tlb_en(tlb_en),
                    .vpn_in(vpn_in),
                    .ppn_in(ppn_in),
                    .we_tlb(we_tlb),
                    .we_mem_protection(we_mem_protection), 
                    .protect_bit_data_write(protect_bit_data_write),
                    .instr_type(instr_type),
                    
                    .ppn_o(ppn_o),
                    .tlb_hit(tlb_hit),
                    .exception(exception)
                );
    
endmodule
