class sub_monitor extends uvm_monitor;
    `uvm_component_utils(sub_monitor)

    sub_agent_config            sub_agnt_config;  
    virtual  sub_intf#(WIDTH)   mon_sub_vif;
    sub_sequence_item           sub_item;

    uvm_analysis_port #(sub_sequence_item) sub_mon_port;

    function new(string name= "sub_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        sub_mon_port = new("sub_mon_port", this);
        
        if(!(uvm_config_db #(sub_agent_config)::get(this,"","sub_agnt_config_name", sub_agnt_config)))
            `uvm_fatal(get_full_name(), "Cannot get Agent Config from configuration database!")
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        mon_sub_vif = sub_agnt_config.sub_vif;
    endfunction :connect_phase

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            sub_item = sub_sequence_item::type_id::create("sub_item");
          
            wait(! mon_sub_vif.rst);
            
            @(posedge mon_sub_vif.clk);
            #(CLK_PERIOD/4.0);
            sub_item.x   = mon_sub_vif.x;
            sub_item.y   = mon_sub_vif.y;
            sub_item.sub = mon_sub_vif.sub;
            sub_item.print();
          
            // send item on scoreboard
            sub_mon_port.write(sub_item);
        end
    endtask: run_phase

endclass: sub_monitor