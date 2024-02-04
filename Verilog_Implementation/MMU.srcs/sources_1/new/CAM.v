module CAM
#(
    parameter DATA_WIDTH = 21,
    parameter ADDR_WIDTH = 6,
    parameter PATH = "CAM.txt"
)
(
    input       clk, 
    input       rst_n,
    input       en,
    input       we,
    input [DATA_WIDTH - 2 : 0]  pattern,                // Vpn to be compared to all 64 line (20 bit VPN)
    input [ADDR_WIDTH - 1 : 0]  wr_addr,    // Write address
    output [ADDR_WIDTH - 1 : 0] maddr,      // Matched address
    output                      mfound
);
    
    integer i;

    reg [DATA_WIDTH - 1 : 0]    ram [2 ** ADDR_WIDTH - 1 : 0];
    
    wire [2 ** ADDR_WIDTH - 1 : 0] match_line;
    
    assign match_line[63] = (ram[63] == {1'b1, pattern});
    assign match_line[62] = (ram[62] == {1'b1, pattern});
    assign match_line[61] = (ram[61] == {1'b1, pattern});
    assign match_line[60] = (ram[60] == {1'b1, pattern});
    assign match_line[59] = (ram[59] == {1'b1, pattern});
    assign match_line[58] = (ram[58] == {1'b1, pattern});
    assign match_line[57] = (ram[57] == {1'b1, pattern});
    assign match_line[56] = (ram[56] == {1'b1, pattern});
    
    assign match_line[55] = (ram[55] == {1'b1, pattern});
    assign match_line[54] = (ram[54] == {1'b1, pattern});
    assign match_line[53] = (ram[53] == {1'b1, pattern});
    assign match_line[52] = (ram[52] == {1'b1, pattern});
    assign match_line[51] = (ram[51] == {1'b1, pattern});
    assign match_line[50] = (ram[50] == {1'b1, pattern});
    assign match_line[49] = (ram[49] == {1'b1, pattern});
    assign match_line[48] = (ram[48] == {1'b1, pattern});
    
    assign match_line[47] = (ram[47] == {1'b1, pattern});
    assign match_line[46] = (ram[46] == {1'b1, pattern});
    assign match_line[45] = (ram[45] == {1'b1, pattern});
    assign match_line[44] = (ram[44] == {1'b1, pattern});
    assign match_line[43] = (ram[43] == {1'b1, pattern});
    assign match_line[42] = (ram[42] == {1'b1, pattern});
    assign match_line[41] = (ram[41] == {1'b1, pattern});
    assign match_line[40] = (ram[40] == {1'b1, pattern});
    
    assign match_line[39] = (ram[39] == {1'b1, pattern});
    assign match_line[38] = (ram[38] == {1'b1, pattern});
    assign match_line[37] = (ram[37] == {1'b1, pattern});
    assign match_line[36] = (ram[36] == {1'b1, pattern});
    assign match_line[35] = (ram[35] == {1'b1, pattern});
    assign match_line[34] = (ram[34] == {1'b1, pattern});
    assign match_line[33] = (ram[33] == {1'b1, pattern});
    assign match_line[32] = (ram[32] == {1'b1, pattern});
    
    assign match_line[31] = (ram[31] == {1'b1, pattern});
    assign match_line[30] = (ram[30] == {1'b1, pattern});
    assign match_line[29] = (ram[29] == {1'b1, pattern});
    assign match_line[28] = (ram[28] == {1'b1, pattern});
    assign match_line[27] = (ram[27] == {1'b1, pattern});
    assign match_line[26] = (ram[26] == {1'b1, pattern});
    assign match_line[25] = (ram[25] == {1'b1, pattern});
    assign match_line[24] = (ram[24] == {1'b1, pattern});
    
    assign match_line[23] = (ram[23] == {1'b1, pattern});
    assign match_line[22] = (ram[22] == {1'b1, pattern});
    assign match_line[21] = (ram[21] == {1'b1, pattern});
    assign match_line[20] = (ram[20] == {1'b1, pattern});
    assign match_line[19] = (ram[19] == {1'b1, pattern});
    assign match_line[18] = (ram[18] == {1'b1, pattern});
    assign match_line[17] = (ram[17] == {1'b1, pattern});
    assign match_line[16] = (ram[16] == {1'b1, pattern});
    
    assign match_line[15] = (ram[15] == {1'b1, pattern});
    assign match_line[14] = (ram[14] == {1'b1, pattern});
    assign match_line[13] = (ram[13] == {1'b1, pattern});
    assign match_line[12] = (ram[12] == {1'b1, pattern});
    assign match_line[11] = (ram[11] == {1'b1, pattern});
    assign match_line[10] = (ram[10] == {1'b1, pattern});
    assign match_line[9] = (ram[9] == {1'b1, pattern});
    assign match_line[8] = (ram[8] == {1'b1, pattern});
    
    assign match_line[7] = (ram[7] == {1'b1, pattern});
    assign match_line[6] = (ram[6] == {1'b1, pattern});
    assign match_line[5] = (ram[5] == {1'b1, pattern});
    assign match_line[4] = (ram[4] == {1'b1, pattern});
    assign match_line[3] = (ram[3] == {1'b1, pattern});
    assign match_line[2] = (ram[2] == {1'b1, pattern});
    assign match_line[1] = (ram[1] == {1'b1, pattern});
    assign match_line[0] = (ram[0] == {1'b1, pattern});
    
    assign mfound = |match_line;
    // encoder match address
    assign maddr[5] =   | match_line[63:32];
    assign maddr[4] =   | (match_line[21:16] | match_line[63:48]);
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
    
    always @ (posedge clk or negedge rst_n) begin
        if (en) begin
            if(!rst_n) begin
                for(i = 0; i < 2 ** ADDR_WIDTH ; i = i + 1) begin
                    ram[i] = 0;
                end
            $readmemb(PATH, ram);
            end
            else begin
                if(we) begin
                    ram[wr_addr] <= {1'b1, pattern};
                    $writememb(PATH, ram);
                end
            end
        end
    end
    
endmodule