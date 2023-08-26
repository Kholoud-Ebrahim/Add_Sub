interface sub_intf #(parameter WIDTH = 8)(input clk, rst);
    logic [WIDTH-1:0] x;
    logic [WIDTH-1:0] y;

    logic [WIDTH:0] sub;
endinterface :sub_intf