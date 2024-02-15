`timescale 1ns/1ps

// Your module here
module RAM_testbench;

// PARAMETER declare here
    parameter DATA_WIDTH = 21;
    parameter ADDR_WIDTH = 10;
    parameter PATH = "ram_L1_init.txt";

// Include your global constants header files here.


// I/O declare here


// WIRES declare here
    wire [(DATA_WIDTH-1) : 0] q;
    wire [(DATA_WIDTH-1) : 0] data;

// REGISTERS declare here
    reg clk;
    reg en;
    reg we;
    reg [(DATA_WIDTH-1) : 0] tmp_data;
    reg [(ADDR_WIDTH-1) : 0] addr;
    
// INITIAL code here
    initial begin
        {clk, en, we, addr, tmp_data} <= 0;
        
        repeat (2) @(posedge clk);
        
        for (integer i = 0; i < 25; i = i+1) begin
            repeat (1) @(negedge clk) begin
                addr <= i;
                en <= 1;
                we <= 1;
                tmp_data <= $random;
            end
        end
        
        for (integer i = 0; i < 50; i = i+1) begin
            repeat (1) @(negedge clk) begin
                addr <= i;
                en <= 1;
                we <= 0;
            end
        end 
        
        #20 $finish;
        
    end

    
// ASSIGNMENTS code here
    assign data = (en && we) ? tmp_data : {DATA_WIDTH{1'bz}};
    
    
// ASYNCHRONOUS code here
    always #1 clk = ~clk;
 
 
// INSTANTIATIONS code here
    RAM #(
          .DATA_WIDTH(DATA_WIDTH),
          .ADDR_WIDTH(ADDR_WIDTH),
          .PATH(PATH)
          ) 
          ram_dut(.q(q),
          .clk(clk),
          .en(en),
          .we(we),
          .data(data),
          .addr(addr)
          );
                                                     

endmodule 
