`timescale 1ns / 1ps

module tlb_translation_tb();

    parameter DATA_WIDTH_CAM = 22;
    parameter DATA_WIDTH_RAM = 20;
    parameter ADDR_WIDTH = 6;
    parameter PATH_INIT_CAM = "CAM.txt";
    parameter PATH_INIT_RAM = "TLB_RAM.txt";
    
    wire [DATA_WIDTH_RAM - 1 : 0] ppn_o;
    wire tlb_hit;
    wire  [ADDR_WIDTH - 1 : 0]     entry_hit;
    wire tlb_full;
    wire [2**ADDR_WIDTH - 1 : 0] mru_out;
    wire [2**ADDR_WIDTH - 1 : 0] valid_out;
    
    reg clk;
    reg rst_n;
    reg tlb_en;
    reg tlb_trans_en;
    reg we;
    reg [DATA_WIDTH_CAM - 3 : 0] vpn_in;
    reg [DATA_WIDTH_RAM - 1 : 0] ppn_in;
    reg [ADDR_WIDTH - 1 : 0]     wr_addr;
    reg mru_add;
    reg mru_update;
    reg mru_clear_all;
    
    initial begin
        {clk, rst_n, tlb_en, tlb_trans_en, we, vpn_in, ppn_in, wr_addr, mru_add, mru_update, mru_clear_all} = 0;
        
        #5 
        tlb_en = 1;
        tlb_trans_en = 1;
        #10
        rst_n = 1;
        
        #10
        vpn_in = 20'b00111000000000000000;
        
        #20
        vpn_in = 20'b10101000000000000000;
        
        #20
        vpn_in = 20'b11001000000000000000;
        
        #20
        vpn_in = 20'b10001000000000000000;
        
        #20
        vpn_in = 20'b11111000000000000000;
        
    end
    
    initial begin
    
        $monitor("[%0t], %0d", $time, tlb_translation.tlb_ram.ram[53]);
    
    end
    
    always #10 clk = ~clk;
    
    TLB_Translation
                    #(
                        .DATA_WIDTH_CAM(DATA_WIDTH_CAM),
                        .DATA_WIDTH_RAM(DATA_WIDTH_RAM),
                        .ADDR_WIDTH(ADDR_WIDTH),
                        .PATH_INIT_CAM(PATH_INIT_CAM),
                        .PATH_INIT_RAM(PATH_INIT_RAM)
                    )
                    tlb_translation
                    (
                        .clk(clk),
                        .rst_n(rst_n),
                        .tlb_en(tlb_en),
                        .tlb_trans_en(tlb_trans_en),
                        .we(we),
                        .vpn_in(vpn_in),
                        .ppn_in(ppn_in),
                        .wr_addr(wr_addr),
                        .mru_add(mru_add),
                        .mru_update(mru_update),
                        .mru_clear_all(mru_clear_all),
                        
                        .ppn_o(ppn_o),
                        .tlb_hit(tlb_hit),
                        .entry_hit(entry_hit),
                        .tlb_full(tlb_full),
                        .valid_out(valid_out),
                        .mru_out(mru_out)
                    );
    
endmodule
