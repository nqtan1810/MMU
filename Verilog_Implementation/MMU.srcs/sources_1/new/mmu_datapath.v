module mmu_datapath
#(
    parameter VPN_WIDTH = 20,
    parameter DATA_WIDTH_L1 = 21,
    parameter DATA_WIDTH_L2 = 4,
    parameter ADDR_WIDTH_L1 = 10,
    parameter ADDR_WIDTH_L2 = 20,
    parameter PATH_INIT_L1 = "ram_L1_init.txt",
    parameter PATH_INIT_L2 = "ram_L2_init.txt",
    parameter EXCPT_WIDTH = 3,
    parameter PROTECTION_BITS_WIDTH = 4,
    
    parameter DATA_WIDTH_CAM = 22,
    parameter DATA_WIDTH_RAM = 20,
    parameter ADDR_WIDTH_TLB = 6,
    parameter PATH_INIT_CAM = "CAM.txt",
    parameter PATH_INIT_RAM = "TLB_RAM.txt"
    
)
(
    clk,
    rst_n,
    tlb_en,
    vpn_in,
    ppn_in,
    we_tlb,
    we_mem_protection, 
    protect_bit_data_write,
    instr_type,
    
    ppn_o,
    tlb_hit,
    exception
);

    input clk;
    input rst_n;
    input tlb_en;
    input [DATA_WIDTH_CAM - 3 : 0] vpn_in;
    input [DATA_WIDTH_RAM - 1 : 0] ppn_in;
    input we_tlb;
    input [1 : 0] we_mem_protection; 
    input [(DATA_WIDTH_L1-1) : 0] protect_bit_data_write;
    input instr_type;
    
    output [DATA_WIDTH_RAM - 1 : 0] ppn_o;
    output tlb_hit;
    output [(EXCPT_WIDTH-1) : 0] exception;

    wire tlb_trans_en;

    Memory_Protection
                    #(
                        .VPN_WIDTH(VPN_WIDTH),
                        .DATA_WIDTH_L1(DATA_WIDTH_L1),
                        .DATA_WIDTH_L2(DATA_WIDTH_L2),
                        .ADDR_WIDTH_L1(ADDR_WIDTH_L1),
                        .ADDR_WIDTH_L2(ADDR_WIDTH_L2),
                        .PATH_INIT_L1(PATH_INIT_L1),
                        .PATH_INIT_L2(PATH_INIT_L2),
                        .EXCPT_WIDTH(EXCPT_WIDTH),
                        .PROTECTION_BITS_WIDTH(PROTECTION_BITS_WIDTH)
                    )
                    mem_protection
                    (   
                        .tlb_trans(tlb_trans_en),
                        .exception(exception),
                        .instr_type(instr_type),
                        .vpn(vpn_in),
                        .access_en(tlb_en),
                        .config_en(we_mem_protection),
                        .config_data(protect_bit_data_write),
                        .clk(clk),
                        .rst_n(rst_n)
                    );
                    
    address_translation
                    #(
                        .DATA_WIDTH_CAM(DATA_WIDTH_CAM),
                        .DATA_WIDTH_RAM(DATA_WIDTH_RAM),
                        .ADDR_WIDTH(ADDR_WIDTH_TLB),
                        .PATH_INIT_CAM(PATH_INIT_CAM),
                        .PATH_INIT_RAM(PATH_INIT_RAM)
                    )
                    address_translation
                    (
                        .clk(clk),
                        .rst_n(rst_n),
                        .tlb_en(tlb_en),
                        .tlb_trans_en(tlb_trans_en),
                        .we(we_tlb),
                        .vpn_in(vpn_in),
                        .ppn_in(ppn_in),
                        .ppn_o(ppn_o),
                        .tlb_hit(tlb_hit)
                    );

endmodule
