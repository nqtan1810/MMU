`timescale 1ns / 1ps

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
