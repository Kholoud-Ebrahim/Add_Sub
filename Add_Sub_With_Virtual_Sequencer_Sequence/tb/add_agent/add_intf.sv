interface add_intf #(parameter WIDTH = 8)(input clk, rst);
    logic [WIDTH-1:0] a;
    logic [WIDTH-1:0] b;

    logic [WIDTH:0] add;
endinterface :add_intf