module RAM
#(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 10,
    parameter PATH = "ram_L1_init.txt"
)
(   
    q,
    clk,
    rst_n,
    en,
    we,
    data,
    addr
);

    output [(DATA_WIDTH-1) : 0] q;
    
    input clk;
    input rst_n;
    input en;
    input we;
    input [(DATA_WIDTH-1) : 0] data;
    input [(ADDR_WIDTH-1) : 0] addr;

    integer i;
    reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
    
    // Variable to hold the registered read address
    reg [ADDR_WIDTH-1:0] addr_reg;
    
// INITIAL code here
    initial 
    begin: INIT
        $readmemb(PATH, ram);
    end

// ASSIGNMENTS code here
    assign q = (en && (!we)) ? ram[addr_reg] : {DATA_WIDTH{1'bz}}; 
    
// SYNCHRONOUS code here
    always @(posedge clk or negedge rst_n) begin
        if (en) begin
            if(!rst_n) begin
                for(i = 0; i < 2 ** ADDR_WIDTH ; i = i + 1) begin
                    ram[i] = 0;
                end
            $readmemb(PATH, ram);
            end
            else begin
                if(we) begin
                    ram[addr] <= data;
                    $writememb(PATH, ram);
                end
                addr_reg <= addr;
            end
        end
    end

endmodule 
