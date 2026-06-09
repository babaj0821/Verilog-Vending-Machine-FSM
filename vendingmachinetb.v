module vending_machine_tb;
    reg clk;
    reg reset;
    reg [1:0] coin;
    reg [1:0] select;
    reg vend;

    wire [7:0] total;
    wire [3:0] product;
    wire [7:0] change;
    wire [2:0] state;

    vending_machine uut (
        .clk(clk),
        .reset(reset),
        .coin(coin),
        .select(select),
        .vend(vend),
        .total(total),
        .product(product),
        .change(change),
        .state(state)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        reset = 1;
        coin = 0;
        select = 0;
        vend = 0;
        #10;
        reset = 0;
        select = 0; 
        vend = 1; 
        #10 vend = 0;

        #10 coin = 2'b01; 
        #10 coin = 2'b00; 
        #10 vend = 1; 
        #10 vend = 0;
        #20;
        reset = 1; #10 reset = 0;
        select = 1; 
        vend = 1; 
        #10 vend = 0;

        #10 coin = 2'b01; 
        #10 vend = 1; 
        #10 vend = 0;

        #20;

        reset = 1; #10 reset = 0;
        select = 2; 
        vend = 1; 
        #10 vend = 0;

        #10 coin = 2'b10; 
        #10 coin = 2'b01; 
        #10 vend = 1; 
        #10 vend = 0;

        #20;
        reset = 1; #10 reset = 0;
        select = 3; 
        vend = 1;
        #10 vend = 0;

        #10 coin = 2'b11; 
        #10 vend = 1; 
        #10 vend = 0;
        #20;

        $display("completed");
        $stop;
	end
endmodule
