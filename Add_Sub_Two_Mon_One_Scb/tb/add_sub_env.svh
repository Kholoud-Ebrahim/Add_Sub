class add_sub_env extends uvm_env;
    `uvm_component_utils(add_sub_env)

    add_agent       add_agnt;
    sub_agent       sub_agnt;

    add_sub_scoreboard  add_sub_scb;

    function new(string name ="add_sub_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        add_agnt    = add_agent::type_id::create("add_agnt", this);
        sub_agnt    = sub_agent::type_id::create("sub_agnt", this);
        add_sub_scb = add_sub_scoreboard::type_id::create("add_sub_scb", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        add_agnt.add_mon.add_mon_port.connect(add_sub_scb.add_scb_imp);
        sub_agnt.sub_mon.sub_mon_port.connect(add_sub_scb.sub_scb_imp);
    endfunction: connect_phase

endclass: add_sub_env