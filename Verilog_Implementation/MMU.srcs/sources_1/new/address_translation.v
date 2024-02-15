module address_translation
    #(
        parameter DATA_WIDTH_CAM = 22,
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
    
        ppn_o,
        tlb_hit
    );

    input clk;
    input rst_n;
    input tlb_en;
    input tlb_trans_en;
    input we;
    input [DATA_WIDTH_CAM - 2 : 0] vpn_in;
    input [DATA_WIDTH_RAM - 1 : 0] ppn_in;
    
    output [DATA_WIDTH_RAM - 1 : 0] ppn_o;
    output tlb_hit;
    
    wire [2**ADDR_WIDTH - 1 : 0] mru;
    wire [2**ADDR_WIDTH - 1 : 0] valid;
    wire tlb_full;
    wire mru_add;
    wire mru_update;
    wire mru_clear_all;
    wire [ADDR_WIDTH - 1 : 0] entry_hit;
    wire [ADDR_WIDTH - 1 : 0] evictim_entry;
    
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
                        .wr_addr(evictim_entry),
                        .mru_add(mru_add),
                        .mru_update(mru_update),
                        .mru_clear_all(mru_clear_all),
                        
                        .ppn_o(ppn_o),
                        .tlb_hit(tlb_hit),
                        .entry_hit(entry_hit),
                        .tlb_full(tlb_full),
                        .valid_out(valid),
                        .mru_out(mru)
                    );
                    
    PLRUm_algorithm
                    #(
                        .ADDR_WIDTH(ADDR_WIDTH)
                    )
                    PLRUm_algorithm
                    (
                        .evictim_entry(evictim_entry),
                        .mru_add(mru_add),
                        .mru_update(mru_update),
                        .mru_clear_all(mru_clear_all),
                        .tlb_miss(!tlb_hit),
                        .entry_hit(entry_hit),
                        .tlb_full(tlb_full),
                        .mru_in(mru),
                        .valid_in(valid)
                    );

endmodule
