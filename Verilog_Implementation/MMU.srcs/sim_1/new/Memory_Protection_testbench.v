//-------------------------------------------------------------------
// Title       : RAM_testbench
// Author      : Nguyen Quoc Truong An
// Created     : 21/10/2023
// Description : This module is used for testing Memory_Protection module
// 
//-------------------------------------------------------------------  

// Timescale declare here
`timescale 1ns/1ps


// Your module here
module Memory_Protection_testbench;
    
    
// PARAMETER declare here
    parameter VPN_WIDTH = 20;
    parameter DATA_WIDTH_L1 = 21;
    parameter DATA_WIDTH_L2 = 4;
    parameter ADDR_WIDTH_L1 = 10;
    parameter ADDR_WIDTH_L2 = 20;
    parameter PATH_INIT_L1 = "ram_L1_init.txt";
    parameter PATH_INIT_L2 = "ram_L2_init.txt";
    parameter EXCPT_WIDTH = 3;
    parameter PROTECTION_BITS_WIDTH = 4;

// Include your global constants header files here.
    
    
// I/O declare here
    

// WIRES declare here
    wire tlb_trans;
    wire [(EXCPT_WIDTH-1) : 0] exception;
    

// REGISTERS declare here  
    reg instr_type; 
    reg [(VPN_WIDTH-1) : 0] vpn;
    reg access_en;
    reg [1 : 0] config_en;
    reg [(DATA_WIDTH_L1-1) : 0] config_data;
    reg clock;
    
// INITIAL code here
    initial begin
        {clock, instr_type, access_en, config_en, config_data, vpn} = 0;
        
        // enable; L1 read; L2 read
        #1 {access_en, config_en, instr_type} = 4'b1000;
        
        for (integer i = 0; i < 10; i = i+1) begin
            
            for (integer j = 0; j < 25; j = j+1) begin
            
                #1 vpn = i * 1024 + j;
                repeat (1) @(posedge clock);
                
            end
        
        end
        
        #1 {access_en, config_en, instr_type} = 4'b1001;
        //instr_type = 1;
        
        for (integer i = 0; i < 10; i = i+1) begin
            
            for (integer j = 0; j < 25; j = j+1) begin
            
                #1 vpn = i * 1024 + j;
                repeat (1) @(posedge clock);
                
            end
        
        end

        
        #10000 $finish; 
    end
    
// ASSIGNMENTS code here
    
    
    
// ASYNCHRONOUS code here
    always #1 clock = ~clock;
    

// INSTANTIATIONS code here
    Memory_Protection#(
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
    memory_protection_dut
    (   
        .tlb_trans(tlb_trans),
        .exception(exception),
        .instr_type(instr_type),
        .vpn(vpn),
        .access_en(access_en),
        .config_en(config_en),
        .config_data(config_data),
        .clock(clock)
        //reset
    );

endmodule 
