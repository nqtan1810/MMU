module PLRUm_algorithm
#(
    parameter ADDR_WIDTH = 6
)
(
    output reg [ADDR_WIDTH - 1 : 0] evictim_entry,
    output reg mru_add,
    output reg mru_update,
    output     mru_clear_all,
    input tlb_miss,
    input [ADDR_WIDTH - 1 : 0] entry_hit,
    input tlb_full,
    input [2**ADDR_WIDTH - 1 : 0] mru_in,
    input [2**ADDR_WIDTH - 1 : 0] valid_in
);
    
    integer i, count; 
    
    reg [2**ADDR_WIDTH - 1 : 0] mru;
    reg [2**ADDR_WIDTH - 1 : 0] mru_tmp;
    
    always @(*) begin
        mru_add = 1'b0;
        mru_update = 1'b0;
        evictim_entry = 1'b0;
        if(tlb_miss) begin
            if(tlb_full) begin                  // TLB is full
                for(i = 2 ** ADDR_WIDTH - 1; i >= 0 ; i = i - 1) begin
                    if(!mru_in[i]) begin
                        evictim_entry = i;                              // find entry to replace
                    end
                end
                mru_add = 1'b0;
                mru_update = 1'b1;
            end
            else begin                                                 // TLB is not full
                for(i = 2 ** ADDR_WIDTH - 1; i >= 0 ; i = i - 1) begin
                    if(!valid_in[i]) begin
                        evictim_entry = i;                             // find free entry to insert a new one
                    end
                end
                mru_add = 1'b1;
                mru_update = 1'b0;
            end
        end 
        
        else begin                                                    // TLB hit => update bit MRU
            evictim_entry = entry_hit;
            mru_add = 1'b0;
            mru_update = 1'b1;
        end 
        
        mru_tmp = mru_in;
        mru_tmp[evictim_entry] = 1'b1;
        
    end

    assign mru_clear_all = mru_tmp == 64'hffffffffffffffff ? 1'b1 : 1'b0;

endmodule
