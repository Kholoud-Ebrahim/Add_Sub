class sub_driver extends uvm_driver #(sub_sequence_item);
    `uvm_component_utils(sub_driver)

    sub_agent_config           sub_agnt_config;
    virtual sub_intf#(WIDTH)   drv_sub_vif;
    sub_sequence_item          sub_item;

    function new(string name= "sub_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        if(!(uvm_config_db #(sub_agent_config)::get(this, "","sub_agnt_config_name", sub_agnt_config)))
          `uvm_fatal(get_full_name(), "Cannot get Agent Config from configuration database!") 
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        drv_sub_vif = sub_agnt_config.sub_vif;
    endfunction :connect_phase

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            seq_item_port.get_next_item(sub_item);
            drive(sub_item);
            seq_item_port.item_done();
        end  
    endtask: run_phase

    task drive(sub_sequence_item sub_item);
        wait(! drv_sub_vif.rst);

        @(negedge drv_sub_vif.clk);
            drv_sub_vif.x <= sub_item.x ;
            drv_sub_vif.y <= sub_item.y ;
    endtask: drive

endclass: sub_driver