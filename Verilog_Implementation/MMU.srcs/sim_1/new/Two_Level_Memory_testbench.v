//-------------------------------------------------------------------
// Title       : RAM_testbench
// Author      : Nguyen Quoc Truong An
// Created     : 21/10/2023
// Description : This module is used for testing RAM module
// 
//-------------------------------------------------------------------  

// Timescale declare here
`timescale 1ns/1ps


// Your module here
module Two_Level_Memory_testbench;

// PARAMETER declare here
   parameter VPN_WIDTH = 20;
   parameter DATA_WIDTH_L1 = 21;
   parameter DATA_WIDTH_L2 = 4;
   parameter ADDR_WIDTH_L1 = 10;
   parameter ADDR_WIDTH_L2 = 20;
   parameter PATH_INIT_L1 = "ram_L1_init.txt";
   parameter PATH_INIT_L2 = "ram_L2_init.txt";

// Include your global constants header files here.


// I/O declare here
    

// WIRES declare here
   wire [(DATA_WIDTH_L2-1) : 0] protection_bits;
    

// REGISTERS declare here
    reg clock;
    reg access_en;
    reg [1 : 0] config_en;
    reg [(DATA_WIDTH_L2-1) : 0] config_data;
    reg [(VPN_WIDTH-1) : 0] vpn;
    
    
// INITIAL code here
    initial begin
        {clock, access_en, config_en, config_data, vpn} = 0;
        
        #2
        // unable 
        {access_en, config_en} = 3'b000;
        
        for (integer i = 0; i < 10; i = i+1) begin
            
            for (integer j = 0; j < 10; j = j+1) begin
            
                #1 vpn = i * 1024 + j;
                repeat (1) @(posedge clock);
                
            end
        
        end
        
        // enable; L1 read; L2 read
        #1 {access_en, config_en} = 3'b100;
        
        for (integer i = 0; i < 10; i = i+1) begin
            
            for (integer j = 0; j < 10; j = j+1) begin
            
                #1 vpn = i * 1024 + j;
                repeat (1) @(posedge clock);
                
            end
        
        end
        
        // enable; L1 read; L2 write
        #1 {access_en, config_en} = 3'b101;
        
        for (integer i = 0; i < 10; i = i+1) begin
            
            for (integer j = 0; j < 10; j = j+1) begin
            
                #1 vpn = i * 1024 + j;
                config_data = j + 5;
                repeat (1) @(posedge clock);
                
            end
        
        end
        
        // enable; L1 read; L2 read
        #1 {access_en, config_en} = 3'b100;
        
        for (integer i = 0; i < 10; i = i+1) begin
            
            for (integer j = 0; j < 10; j = j+1) begin
            
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
    Two_Level_Memory #(
                           .VPN_WIDTH(VPN_WIDTH),
                           .DATA_WIDTH_L1(DATA_WIDTH_L1),
                           .DATA_WIDTH_L2(DATA_WIDTH_L2),
                           .ADDR_WIDTH_L1(ADDR_WIDTH_L1),
                           .ADDR_WIDTH_L2(ADDR_WIDTH_L2),
                           .PATH_INIT_L1(PATH_INIT_L1),
                           .PATH_INIT_L2(PATH_INIT_L2)
                       )
                       two_level_memory_dut 
                       (
                           .protection_bits(protection_bits),
                           .clock(clock),
                           .access_en(access_en),
                           .config_en(config_en),
                           .config_data(config_data),
                           .vpn(vpn)
                       );
                                                         

endmodule 
