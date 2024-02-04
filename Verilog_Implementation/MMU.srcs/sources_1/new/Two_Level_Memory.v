module Two_Level_Memory
#(
    parameter VPN_WIDTH = 20,
    parameter DATA_WIDTH_L1 = 21,
    parameter DATA_WIDTH_L2 = 4,
    parameter ADDR_WIDTH_L1 = 10,
    parameter ADDR_WIDTH_L2 = 20,
    parameter PATH_INIT_L1 = "ram_L1_init.txt",
    parameter PATH_INIT_L2 = "ram_L2_init.txt"
)
(   
    protection_bits,
    clk,
    rst_n,
    access_en,
    config_en,
    config_data,
    vpn
);
// I/O declare here
    output [(DATA_WIDTH_L2-1) : 0] protection_bits;
    
    input clk;
    input rst_n;
    input access_en;
    input [1:0] config_en;
    input [(DATA_WIDTH_L1-1) : 0] config_data;
    input [(VPN_WIDTH-1) : 0] vpn;

// WIRES declare here
    wire [(DATA_WIDTH_L1-1) : 0] output_L1;
    wire [(DATA_WIDTH_L1-1) : 0] base_page_num_L2;
    wire access_en_L2;
    
// REGISTERS declare here
    reg [(VPN_WIDTH-1) : 0] latch_vpn;
    reg [(DATA_WIDTH_L1-1) : 0] latch_config_data;
    reg latch_access_en_L2;
    reg latch_config_en_L2;

// ASSIGNMENTS code here
   assign base_page_num_L2 = output_L1[DATA_WIDTH_L1-1] ? output_L1 : {DATA_WIDTH_L1{1'bz}};
   assign access_en_L2 = access_en & (~config_en[1]);

// SYNCHRONOUS code here
    always @(posedge clk) begin
        latch_vpn <= vpn;
        latch_config_data <= config_data;
        latch_access_en_L2 <= access_en_L2;
        latch_config_en_L2 <= config_en[0];
    end

// INSTANTIATIONS code here
    RAM #(
              .DATA_WIDTH(DATA_WIDTH_L1),
              .ADDR_WIDTH(ADDR_WIDTH_L1),
              .PATH(PATH_INIT_L1)
          ) 
          ram_l1 
          (
              .q(output_L1),
              .clk(clk),
              .rst_n(rst_n),
              .en(access_en),
              .we(config_en[1]),
              .data(config_data),
              .addr(vpn[(VPN_WIDTH-1) : ADDR_WIDTH_L1])
          );
             
    RAM #(
              .DATA_WIDTH(DATA_WIDTH_L2),
              .ADDR_WIDTH(ADDR_WIDTH_L2),
              .PATH(PATH_INIT_L2)
          ) 
          ram_l2 
          (
              .q(protection_bits),
              .clk(clk),
              .rst_n(rst_n),
              .en(latch_access_en_L2),
              .we(latch_config_en_L2),
              .data(latch_config_data[(DATA_WIDTH_L2-1) : 0]),
              .addr(base_page_num_L2[(ADDR_WIDTH_L2-1) : 0] + latch_vpn[ADDR_WIDTH_L1-1:0])
          );

endmodule 
