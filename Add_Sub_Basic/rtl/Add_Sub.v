module Add_Sub #(parameter WIDTH = 8)(clk, rst, a, b, x, y, add, sub);
    input clk, rst;
    input  [WIDTH-1:0] a, b, x, y;
    output reg [WIDTH:0] add, sub;
  
    always @(posedge clk, negedge rst) begin
        if (rst) begin
            add <= 0;
            sub <= 0;
        end
        else begin
            add <= a + b;
            sub <= x - y;
        end

    end
endmodule