module Memory_Protection
#(
    parameter VPN_WIDTH = 20,
    parameter DATA_WIDTH_L1 = 21,
    parameter DATA_WIDTH_L2 = 4,
    parameter ADDR_WIDTH_L1 = 10,
    parameter ADDR_WIDTH_L2 = 20,
    parameter PATH_INIT_L1 = "ram_L1_init.txt",
    parameter PATH_INIT_L2 = "ram_L2_init.txt",
    parameter EXCPT_WIDTH = 3,
    parameter PROTECTION_BITS_WIDTH = 4
)
(   
    tlb_trans,
    exception,
    instr_type,
    vpn,
    access_en,
    config_en,
    config_data,
    clk,
    rst_n
);

    output tlb_trans;
    output [(EXCPT_WIDTH-1) : 0] exception;
    
    input instr_type;
    input [(VPN_WIDTH-1) : 0] vpn;
    input access_en;
    input [1 : 0] config_en;
    input [(DATA_WIDTH_L1-1) : 0] config_data;
    input clk;
    input rst_n;

    wire [(DATA_WIDTH_L2-1) : 0] protection_bits;

    Two_Level_Memory #(
                    .VPN_WIDTH(VPN_WIDTH),
                    .DATA_WIDTH_L1(DATA_WIDTH_L1),
                    .DATA_WIDTH_L2(DATA_WIDTH_L2),
                    .ADDR_WIDTH_L1(ADDR_WIDTH_L1),
                    .ADDR_WIDTH_L2(ADDR_WIDTH_L2),
                    .PATH_INIT_L1(PATH_INIT_L1),
                    .PATH_INIT_L2(PATH_INIT_L2)
                )
                two_level_mem
                (   
                    .protection_bits(protection_bits),
                    .clk(clk),
                    .rst_n(rst_n),
                    .access_en(access_en),
                    .config_en(config_en),
                    .config_data(config_data),
                    .vpn(vpn)
                );
    
    Check_Logic #(
                    .EXCPT_WIDTH(EXCPT_WIDTH),
                    .PROTECTION_BITS_WIDTH(PROTECTION_BITS_WIDTH)
                )
                check_logic
                (
                    .tlb_trans_en(tlb_trans),
                    .exception(exception),
                    .instr_type(instr_type),
                    .protection_bits(protection_bits)
                );

endmodule 
