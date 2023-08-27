class sub_monitor extends uvm_monitor;
    `uvm_component_utils(sub_monitor)

    virtual  sub_intf#(WIDTH)  sub_vif;
    sub_sequence_item  sub_item;

    uvm_analysis_port #(sub_sequence_item) sub_mon_port;

    function new(string name= "sub_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        sub_mon_port = new("sub_mon_port", this);
        
        if(!(uvm_config_db #(virtual sub_intf#(WIDTH))::get(this,"*","sub_vif", sub_vif)))
            `uvm_fatal(get_type_name(), "Failed to get VIF config db")
    endfunction: build_phase

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            sub_item = sub_sequence_item::type_id::create("sub_item");
          
            wait(! sub_vif.rst);
            
            @(posedge sub_vif.clk);
            #(CLK_PERIOD/4.0);
            sub_item.x   = sub_vif.x;
            sub_item.y   = sub_vif.y;
            sub_item.sub = sub_vif.sub;
            sub_item.print();
          
            // send item on scoreboard
            sub_mon_port.write(sub_item);
        end
    endtask: run_phase

endclass: sub_monitor