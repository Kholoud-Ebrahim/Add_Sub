`timescale 1ns/1ns

`ifndef ADD_SUB_TOP_SV
`define ADD_SUB_TOP_SV

import uvm_pkg::*;
import param_pkg::*;
import add_sub_pkg::*;

module add_sub_top;
    bit clk, rst;

    add_intf #(WIDTH)add_intf_h(clk, rst);
    sub_intf #(WIDTH)sub_intf_h(clk, rst);
    Add_Sub #(WIDTH)rtl(clk, rst, add_intf_h.a, add_intf_h.b, sub_intf_h.x, sub_intf_h.y, add_intf_h.add, sub_intf_h.sub);

    initial begin
        uvm_config_db #(virtual add_intf #(WIDTH))::set(null,"*","add_vif",add_intf_h);
        uvm_config_db #(virtual sub_intf #(WIDTH))::set(null,"*","sub_vif",sub_intf_h);

        run_test(); 
    end

    initial begin
        rst = 1; #(CLK_PERIOD*2.0); rst = 0;
    end

    initial begin
        clk  =1;
        forever begin
            #(CLK_PERIOD/2.0); clk = ~clk;
        end
    end

endmodule :add_sub_top
`endif