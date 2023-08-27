`timescale 1ns/1ns

`ifndef ADD_SUB_TOP_SV
`define ADD_SUB_TOP_SV

import uvm_pkg::*;
import param_pkg::*;
import add_sub_pkg::*;

module add_sub_top;
    bit clk, rst;

    add_intf #(WIDTH)add_vif(clk, rst);
    sub_intf #(WIDTH)sub_vif(clk, rst);
    Add_Sub #(WIDTH)rtl(clk, rst, add_vif.a, add_vif.b, sub_vif.x, sub_vif.y, add_vif.add, sub_vif.sub);

    initial begin
        uvm_config_db #(virtual add_intf #(WIDTH))::set(null,"*","add_vif",add_vif);
        uvm_config_db #(virtual sub_intf #(WIDTH))::set(null,"*","sub_vif",sub_vif);

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