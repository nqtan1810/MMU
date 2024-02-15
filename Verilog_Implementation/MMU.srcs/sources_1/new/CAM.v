module CAM
#(
    parameter DATA_WIDTH = 22,
    parameter ADDR_WIDTH = 6,
    parameter PATH = "CAM.txt"
)
(
    input       clk, 
    input       rst_n,
    input       en,
    input       we,
    input [DATA_WIDTH - 3 : 0]  pattern,                // Vpn to be compared to all 64 line (20 bit VPN)
    input [ADDR_WIDTH - 1 : 0]  wr_addr,    // Write address
    input mru_add,
    input mru_update,
    input mru_clear_all,
    
    output [ADDR_WIDTH - 1 : 0] maddr,      // Matched address
    output reg                  mfound,      // TLB hit,
    output reg [2**ADDR_WIDTH - 1 : 0] mru_out,
    output reg [2**ADDR_WIDTH - 1 : 0] valid_out,
    output tlb_full
);
    
    integer i, j, k, l, m, n;

    reg [DATA_WIDTH - 1 : 0] ram [2 ** ADDR_WIDTH - 1 : 0];
    
    wire [2 ** ADDR_WIDTH - 1 : 0] match_line;
    
    // INITIAL code here
    initial 
    begin: INIT
        $readmemb(PATH, ram);
    end
    
    assign match_line[63] = (ram[63][20:0] == {1'b1, pattern});
    assign match_line[62] = (ram[62][20:0] == {1'b1, pattern});
    assign match_line[61] = (ram[61][20:0] == {1'b1, pattern});
    assign match_line[60] = (ram[60][20:0] == {1'b1, pattern});
    assign match_line[59] = (ram[59][20:0] == {1'b1, pattern});
    assign match_line[58] = (ram[58][20:0] == {1'b1, pattern});
    assign match_line[57] = (ram[57][20:0] == {1'b1, pattern});
    assign match_line[56] = (ram[56][20:0] == {1'b1, pattern});
    
    assign match_line[55] = (ram[55][20:0] == {1'b1, pattern});
    assign match_line[54] = (ram[54][20:0] == {1'b1, pattern});
    assign match_line[53] = (ram[53][20:0] == {1'b1, pattern});
    assign match_line[52] = (ram[52][20:0] == {1'b1, pattern});
    assign match_line[51] = (ram[51][20:0] == {1'b1, pattern});
    assign match_line[50] = (ram[50][20:0] == {1'b1, pattern});
    assign match_line[49] = (ram[49][20:0] == {1'b1, pattern});
    assign match_line[48] = (ram[48][20:0] == {1'b1, pattern});
    
    assign match_line[47] = (ram[47][20:0] == {1'b1, pattern});
    assign match_line[46] = (ram[46][20:0] == {1'b1, pattern});
    assign match_line[45] = (ram[45][20:0] == {1'b1, pattern});
    assign match_line[44] = (ram[44][20:0] == {1'b1, pattern});
    assign match_line[43] = (ram[43][20:0] == {1'b1, pattern});
    assign match_line[42] = (ram[42][20:0] == {1'b1, pattern});
    assign match_line[41] = (ram[41][20:0] == {1'b1, pattern});
    assign match_line[40] = (ram[40][20:0] == {1'b1, pattern});
    
    assign match_line[39] = (ram[39][20:0] == {1'b1, pattern});
    assign match_line[38] = (ram[38][20:0] == {1'b1, pattern});
    assign match_line[37] = (ram[37][20:0] == {1'b1, pattern});
    assign match_line[36] = (ram[36][20:0] == {1'b1, pattern});
    assign match_line[35] = (ram[35][20:0] == {1'b1, pattern});
    assign match_line[34] = (ram[34][20:0] == {1'b1, pattern});
    assign match_line[33] = (ram[33][20:0] == {1'b1, pattern});
    assign match_line[32] = (ram[32][20:0] == {1'b1, pattern});
    
    assign match_line[31] = (ram[31][20:0] == {1'b1, pattern});
    assign match_line[30] = (ram[30][20:0] == {1'b1, pattern});
    assign match_line[29] = (ram[29][20:0] == {1'b1, pattern});
    assign match_line[28] = (ram[28][20:0] == {1'b1, pattern});
    assign match_line[27] = (ram[27][20:0] == {1'b1, pattern});
    assign match_line[26] = (ram[26][20:0] == {1'b1, pattern});
    assign match_line[25] = (ram[25][20:0] == {1'b1, pattern});
    assign match_line[24] = (ram[24][20:0] == {1'b1, pattern});
    
    assign match_line[23] = (ram[23][20:0] == {1'b1, pattern});
    assign match_line[22] = (ram[22][20:0] == {1'b1, pattern});
    assign match_line[21] = (ram[21][20:0] == {1'b1, pattern});
    assign match_line[20] = (ram[20][20:0] == {1'b1, pattern});
    assign match_line[19] = (ram[19][20:0] == {1'b1, pattern});
    assign match_line[18] = (ram[18][20:0] == {1'b1, pattern});
    assign match_line[17] = (ram[17][20:0] == {1'b1, pattern});
    assign match_line[16] = (ram[16][20:0] == {1'b1, pattern});
    
    assign match_line[15] = (ram[15][20:0] == {1'b1, pattern});
    assign match_line[14] = (ram[14][20:0] == {1'b1, pattern});
    assign match_line[13] = (ram[13][20:0] == {1'b1, pattern});
    assign match_line[12] = (ram[12][20:0] == {1'b1, pattern});
    assign match_line[11] = (ram[11][20:0] == {1'b1, pattern});
    assign match_line[10] = (ram[10][20:0] == {1'b1, pattern});
    assign match_line[9]  = (ram[9][20:0]  == {1'b1, pattern});
    assign match_line[8]  = (ram[8][20:0]  == {1'b1, pattern});
    
    assign match_line[7]  = (ram[7][20:0]  == {1'b1, pattern});
    assign match_line[6]  = (ram[6][20:0]  == {1'b1, pattern});
    assign match_line[5]  = (ram[5][20:0]  == {1'b1, pattern});
    assign match_line[4]  = (ram[4][20:0]  == {1'b1, pattern});
    assign match_line[3]  = (ram[3][20:0]  == {1'b1, pattern});
    assign match_line[2]  = (ram[2][20:0]  == {1'b1, pattern});
    assign match_line[1]  = (ram[1][20:0]  == {1'b1, pattern});
    assign match_line[0]  = (ram[0][20:0]  == {1'b1, pattern});
    
    // encoder match address
    assign maddr[5] =   | match_line[63:32];
    assign maddr[4] =   | (match_line[31:16] | match_line[63:48]);
    assign maddr[3] =   | (match_line[15:8] | match_line[31:24] | match_line[47:40] | match_line[63:56]);
    assign maddr[2] =   | (match_line[7:4] | match_line[15:12] | match_line[23:20] | match_line[31:28] |
                           match_line[39:36] | match_line[47:44] | match_line[55:52] | match_line[63:60]);
    assign maddr[1] =   | (match_line[3:2] | match_line[7:6] | match_line[11:10] | match_line[15:14] |
                           match_line[19:18] | match_line[23:22] | match_line[27:26] | match_line[31:30] |
                           match_line[35:34] | match_line[39:38] | match_line[43:42] | match_line[47:46] |
                           match_line[51:50] | match_line[55:54] | match_line[59:58] | match_line[63:62]);
    assign maddr[0] =   | (match_line[1] | match_line[3] | match_line[5] | match_line[7] |
                           match_line[9] | match_line[11] | match_line[13] | match_line[15] |
                           match_line[17] | match_line[19] | match_line[21] | match_line[23] |
                           match_line[25] | match_line[27] | match_line[29] | match_line[31] |
                           match_line[33] | match_line[35] | match_line[37] | match_line[39] |
                           match_line[41] | match_line[43] | match_line[45] | match_line[47] |
                           match_line[49] | match_line[51] | match_line[53] | match_line[55] |
                           match_line[57] | match_line[59] | match_line[61] | match_line[63]);
                           

//    always @(*) begin
//        for(l = 0; l < 2 ** ADDR_WIDTH ; l = l + 1) begin
//            if(ram[l][20:0] == {1'b1, pattern})
//                maddr = i;
//            else 
//                maddr = {ADDR_WIDTH{1'bz}};
//        end      
//    end
    
    always @ (posedge clk or negedge rst_n) begin
        if (en) begin                                                   // TLB access enable
            if(!rst_n) begin                                            // reset TLB
                for(i = 0; i < 2 ** ADDR_WIDTH ; i = i + 1) begin
                    ram[i] = 0;
                end
            $readmemb(PATH, ram);
            end
            
            else begin
                if(we) begin                                            // write enable
                    if(mru_add) begin                                   // add entry
                        ram[wr_addr] <= {2'b11, pattern};
                    end
                    else if(mru_update) begin                           // update MRU bit
                        ram[wr_addr][DATA_WIDTH-1] <= 1'b1;
                    end
                    else if(mru_clear_all) begin                        // clear all MRU bits to avoid deadlock
                        for(j = 0; j < 2 ** ADDR_WIDTH ; j = j + 1) begin
                            ram[j][DATA_WIDTH-1] <= 1'b0;
                        end  
                        ram[wr_addr][DATA_WIDTH-1] <= 1'b1;    
                    end
                    $writememb(PATH, ram);
                end
            end
            mfound = (|match_line === 1'b1) ? 1 : 0; 
        end
    end
    
    always @(*) begin
        for(k = 0; k < 2 ** ADDR_WIDTH ; k = k + 1) begin
            mru_out[k] = ram[k][21];
            valid_out[k] = ram[k][20];
        end      
    end
    
    assign tlb_full = valid_out == 64'hffffffffffffffff ? 1'b1 : 1'b0;      // TLB is full or not full
    
endmodule