module vending_machine(
    input clk,          
    input reset,        
    input [1:0] coin,   
    input [1:0] select, 
    input vend,         
    output reg [7:0] total, 
    output reg [3:0] product, 
    output reg [7:0] change, 
    output reg [2:0] state   
);

    // Define product prices
    parameter PRICE_A = 8'd10;
    parameter PRICE_B = 8'd20;
    parameter PRICE_C = 8'd30;
    parameter PRICE_D = 8'd40;
    //how many do we have
    reg [7:0]product_0 = 5; 
    reg [7:0]product_1 = 4;
    reg [7:0]product_2 = 2;
    reg [7:0]product_3 = 7;

    // Define states
    parameter IDLE = 3'b000;
    parameter AVAILABLE = 3'b001;
    parameter WAIT_COIN = 3'b010;
    parameter CHECK_AMOUNT = 3'b011;
    parameter DISPENSE = 3'b100;
    parameter GIVE_CHANGE = 3'b101;


    // Initial state
    initial begin
        state = IDLE;
        total = 0;
        product = 0;
        change = 0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            total <= 0;
            product <= -1;
            change <= 0;
        end else begin
            case (state)
                IDLE: begin
                    total <= 0;
                    product <= -1;
                    change <= 0;
                    if (vend) begin
                        state <= AVAILABLE;
                    end
                end
		AVAILABLE: begin
			case(select)
			0 :  if (product_0 > 0) state <= WAIT_COIN;else state <= IDLE;  
			1 :  if (product_1 > 0) state <= WAIT_COIN; else  state <= IDLE; 
			2 :  if (product_2 > 0) state <= WAIT_COIN; else  state <= IDLE;  
			3 :  if (product_3 > 0) state <= WAIT_COIN; else  state <= IDLE;  
			endcase
		end
                WAIT_COIN: begin
                    case (coin)
                        0 : total <= total + 1;
                        1 : total <= total + 10;
                        2 : total <= total + 20;
                        3 : total <= total + 50;
                    endcase
                    if (vend)state <= CHECK_AMOUNT;
                	end

                CHECK_AMOUNT: begin
                    case (select)
                        0 : if (total >= PRICE_A) state <= DISPENSE; else state <= WAIT_COIN;
                        1 : if (total >= PRICE_B) state <= DISPENSE; else state <= WAIT_COIN;
                        2 : if (total >= PRICE_C) state <= DISPENSE; else state <= WAIT_COIN;
                        3 : if (total >= PRICE_D) state <= DISPENSE; else state <= WAIT_COIN;
                    endcase
                end

                DISPENSE: begin
                    case (select)
                        0 : begin
                            product <= 0;
                            change <= total - PRICE_A;
			    product_0 = product_0 - 1;
                        end
                        1 : begin
                            product <= 1;
                            change <= total - PRICE_B;
			    product_1 = product_1 - 1;
                        end
                        2 : begin
                            product <= 2;
                            change <= total - PRICE_C;
			    product_2 = product_2 - 1;
                        end
                        3 : begin
                            product <= 3;
                            change <= total - PRICE_D;
			    product_3 = product_3 - 1;
                        end
                    endcase
                    state <= GIVE_CHANGE;
                end

                GIVE_CHANGE: begin
                    change <= total;
                    total <= 0;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
