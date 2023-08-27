class add_monitor extends uvm_monitor;
    `uvm_component_utils(add_monitor)

    virtual  add_intf#(WIDTH)  add_vif;
    add_sequence_item  add_item;

    uvm_analysis_port #(add_sequence_item) add_mon_port;

    function new(string name= "add_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        add_mon_port = new("add_mon_port", this);
        
        if(!(uvm_config_db #(virtual add_intf#(WIDTH))::get(this,"*","add_vif", add_vif)))
            `uvm_fatal(get_type_name(), "Failed to get VIF config db")
    endfunction: build_phase

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            add_item = add_sequence_item::type_id::create("add_item");
          
            wait(! add_vif.rst);
            
            @(posedge add_vif.clk);
            #(CLK_PERIOD/4.0);
            add_item.a   = add_vif.a;
            add_item.b   = add_vif.b;
            add_item.add = add_vif.add;
          
            add_item.print();
            
            // send item on scoreboard
            add_mon_port.write(add_item);
        end
    endtask: run_phase

endclass: add_monitor