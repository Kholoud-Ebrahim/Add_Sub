class add_driver extends uvm_driver #(add_sequence_item);
    `uvm_component_utils(add_driver)

    add_agent_config           add_agnt_config;
    virtual add_intf#(WIDTH)   drv_add_vif;
    add_sequence_item          add_item;

    function new(string name= "add_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        if(!(uvm_config_db #(add_agent_config)::get(this, "","add_agnt_config_name", add_agnt_config)))
          `uvm_fatal(get_full_name(),"Cannot get Agent Config from configuration database!") 
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        drv_add_vif = add_agnt_config.add_vif;
    endfunction :connect_phase

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            seq_item_port.get_next_item(add_item);
            drive(add_item);
            seq_item_port.item_done();
        end  
    endtask: run_phase

    task drive(add_sequence_item add_item);
        wait(! drv_add_vif.rst);

        @(negedge drv_add_vif.clk);
            drv_add_vif.a <= add_item.a ;
            drv_add_vif.b <= add_item.b ;
    endtask: drive

endclass: add_driver