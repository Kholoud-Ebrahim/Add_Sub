class sub_driver extends uvm_driver #(sub_sequence_item);
    `uvm_component_utils(sub_driver)

    virtual sub_intf#(WIDTH)   sub_vif;
    sub_sequence_item  sub_item;

    function new(string name= "sub_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        if(!(uvm_config_db #(virtual sub_intf#(WIDTH))::get(this, "*","sub_vif", sub_vif)))
          `uvm_fatal(get_type_name(),"Failed to get VIF config db") 
    endfunction: build_phase

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            seq_item_port.get_next_item(sub_item);
            drive(sub_item);
            seq_item_port.item_done();
        end  
    endtask: run_phase

    task drive(sub_sequence_item sub_item);
        wait(! sub_vif.rst);

        @(negedge sub_vif.clk);
            sub_vif.x <= sub_item.x ;
            sub_vif.y <= sub_item.y ;
    endtask: drive

endclass: sub_driver