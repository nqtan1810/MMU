`timescale 1ns / 1ps

module CAM_testbench();
    
    parameter DATA_WIDTH = 22;
    parameter ADDR_WIDTH = 6;
    parameter PATH = "CAM.txt";
    
    reg       clk;
    reg       rst_n;
    reg       en;
    reg       we;
    reg [DATA_WIDTH - 3 : 0]  pattern;               // Vpn to be compared to all 64 line (20 bit VPN)
    reg [ADDR_WIDTH - 1 : 0]  wr_addr;    // Write address
    reg mru_add;
    reg mru_update;
    reg mru_clear_all;
    
    wire [ADDR_WIDTH - 1 : 0] maddr;     // Matched address
    wire                  mfound;      // TLB hit,
    wire [2**ADDR_WIDTH - 1 : 0] mru_out;
    wire [2**ADDR_WIDTH - 1 : 0] valid_out;
    wire tlb_full;
    
    CAM #(
            .DATA_WIDTH(DATA_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH),
            .PATH(PATH)
        )
        cam
        (
            .clk(clk), 
            .rst_n(rst_n),
            .en(en),
            .we(we),
            .pattern(pattern),
            .wr_addr(wr_addr),  // mux
            .mru_add(mru_add),
            .mru_update(mru_update),
            .mru_clear_all(mru_clear_all),
            .maddr(maddr),      
            .mfound(mfound),
            .mru_out(mru_out),
            .valid_out(valid_out),
            .tlb_full(tlb_full)
        );
        
    always #5 clk = ~clk;
    
    integer i;
    initial begin
    
        {clk, rst_n, en, we, pattern, wr_addr, mru_add, mru_update, mru_clear_all} = 0;
        #7
        en = 1;
        #1
        rst_n = 1;
        #1
        rst_n = 0;
        #1
        rst_n = 1;
        we = 1;
        mru_add = 1;
        
//        for(i = 0; i < 2 ** ADDR_WIDTH; i = i + 1) begin
//            #10 pattern = i;
//            wr_addr = i;
//        end
        
        
        #10
        pattern = 10;
        wr_addr = 20;
        
        #10
        pattern = 20;
        wr_addr = 40;
        
        #1
        we = 1;
        #9
        pattern = 20'b01011000000000000000;
        
        #10
        pattern = 20'b11101000000000000000;
        
        #10
        pattern = 20'b01011000000000000000;
        
        #10
        pattern = 20'b11000000000000000000;
        
        #10 $stop;
        
    
    end
    
endmodule
