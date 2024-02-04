module Check_Logic #(
                        parameter EXCPT_WIDTH = 3,
                        parameter PROTECTION_BITS_WIDTH = 4
                    )
                    (
                        tlb_trans_en,
                        exception,
                        instr_type,
                        protection_bits
                    );

// Include your global constants header files here.

// DEFINE here
    //`define invalid_page_fault_excpt                3'b000;
    //`define fetch_page_fault_excpt                  3'b001;
    //`define load_page_fault_excpt                   3'b010;
    //`define store_page_fault_excpt                  3'b011;
    //`define pointer_to_next_level_of_page_excpt     3'b100;
    //`define reserved_for_future_use_excpt           3'b101;
    //`define none_error_excpt                        3'b111;
    
    

// I/O declare here
    output tlb_trans_en;
    output [(EXCPT_WIDTH-1) : 0] exception;
    
    input instr_type;       // execute+read = 0  |  execute+write = 1;
    input [(PROTECTION_BITS_WIDTH-1) : 0] protection_bits;  // {V, X, W, R}

// WIRES declare here
    

// REGISTERS declare here
    reg tlb_trans_en;       // enable address translation when 1, else disable when 0
    reg [(EXCPT_WIDTH-1) : 0] exception;

    
    reg V;
    reg X;
    reg W;
    reg R;

    always @(*) begin
        V = protection_bits[PROTECTION_BITS_WIDTH-1];
        X = protection_bits[PROTECTION_BITS_WIDTH-2];
        W = protection_bits[PROTECTION_BITS_WIDTH-3];
        R = protection_bits[PROTECTION_BITS_WIDTH-4];
    end
    
    always @(*) begin
        if (V) begin
            casex ({instr_type, X, W, R})
                4'b?000: begin
                            tlb_trans_en = 0;
                            exception = 3'b100; 
                        end
                
                4'b?001: begin
                            tlb_trans_en = 0;
                            exception = 3'b001;
                        end
                
                4'b?010: begin
                            tlb_trans_en = 0;
                            exception = 3'b101;
                        end
                
                4'b?011: begin
                            tlb_trans_en = 0;
                            exception = 3'b001;
                        end 
                        
                4'b0100: begin
                            tlb_trans_en = 0;
                            exception = 3'b010;
                        end 
                        
                4'b0101: begin
                            tlb_trans_en = 1;
                            exception = 3'b111;
                        end 
                        
                4'b110?: begin
                            tlb_trans_en = 0;
                            exception = 3'b011;
                        end 
                        
                4'b?110: begin
                            tlb_trans_en = 0;
                            exception = 3'b101;
                        end 
                
                4'b?111: begin
                            tlb_trans_en = 1;
                            exception = 3'b111;
                        end
                default: begin
                            tlb_trans_en = 0;
                            exception = 3'b000;   
                        end         
                endcase
            end
            
        else begin
            tlb_trans_en = 0;
            exception = 3'b000;
        end 
    end

endmodule 
