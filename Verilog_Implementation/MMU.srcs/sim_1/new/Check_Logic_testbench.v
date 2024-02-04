`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2023 07:04:15 PM
// Design Name: 
// Module Name: Check_Logic_testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Check_Logic_testbench();
wire [3:0]protection_bits = 4'b1111;
wire tlb_trans;
wire [2:0]exception;
wire instr_type = 0;

Check_Logic check_logic
                (
                    .tlb_trans_en(tlb_trans),
                    .exception(exception),
                    .instr_type(instr_type),
                    .protection_bits(protection_bits)
                );
endmodule
