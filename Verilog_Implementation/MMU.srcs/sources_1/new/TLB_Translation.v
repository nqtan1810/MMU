module TLB_Translation
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
    wr_addr,
    mru_add,
    mru_update,
    mru_clear_all,
    
    ppn_o,
    tlb_hit,
    entry_hit,
    tlb_full,
    valid_out,
    mru_out
);

    output [DATA_WIDTH_RAM - 1 : 0] ppn_o;
    output tlb_hit;
    output  [ADDR_WIDTH - 1 : 0]     entry_hit;
    output tlb_full;
    output [2**ADDR_WIDTH - 1 : 0] mru_out;
    output [2**ADDR_WIDTH - 1 : 0] valid_out;
    
    input clk;
    input rst_n;
    input tlb_en;
    input tlb_trans_en;
    input we;
    input [DATA_WIDTH_CAM - 3 : 0] vpn_in;
    input [DATA_WIDTH_RAM - 1 : 0] ppn_in;
    input [ADDR_WIDTH - 1 : 0]     wr_addr;
    input mru_add;
    input mru_update;
    input mru_clear_all;
    
    wire  en;
    wire  [ADDR_WIDTH - 1 : 0]     ram_addr;
    wire  we_cam;
    
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
            .we(we_cam),
            .pattern(vpn_in),
            .wr_addr(wr_addr),  // mux
            .mru_add(mru_add),
            .mru_update(mru_update),
            .mru_clear_all(mru_clear_all),
            .maddr(entry_hit),      
            .mfound(tlb_hit),
            .mru_out(mru_out),
            .valid_out(valid_out),
            .tlb_full(tlb_full)
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
              .rst_n(rst_n),
              .en(en),
              .we(we),
              .data(ppn_in),
              .addr(ram_addr)
          );
    
    assign en = tlb_en | tlb_trans_en;
    assign ram_addr = we ? wr_addr : entry_hit;
    assign we_cam = we | (!tlb_hit); 

endmodule
