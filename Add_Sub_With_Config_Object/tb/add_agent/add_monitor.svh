class add_monitor extends uvm_monitor;
    `uvm_component_utils(add_monitor)

    add_agent_config           add_agnt_config;
    virtual  add_intf#(WIDTH)  mon_add_vif;
    add_sequence_item  add_item;

    uvm_analysis_port #(add_sequence_item) add_mon_port;

    function new(string name= "add_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        add_mon_port = new("add_mon_port", this);
        
        if(!(uvm_config_db #(add_agent_config)::get(this,"","add_agnt_config_name", add_agnt_config)))
            `uvm_fatal(get_type_name(), "Cannot get Agent Config from configuration database!")
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        mon_add_vif = add_agnt_config.add_vif;
    endfunction :connect_phase


    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            add_item = add_sequence_item::type_id::create("add_item");
          
            wait(! mon_add_vif.rst);
            
            @(posedge mon_add_vif.clk);
            #(CLK_PERIOD/4.0);
            add_item.a   = mon_add_vif.a;
            add_item.b   = mon_add_vif.b;
            add_item.add = mon_add_vif.add;
          
            add_item.print();
            
            // send item on scoreboard
            add_mon_port.write(add_item);
        end
    endtask: run_phase

endclass: add_monitor