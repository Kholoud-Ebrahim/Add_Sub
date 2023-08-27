class add_sub_env extends uvm_env;
    `uvm_component_utils(add_sub_env)

    add_agent       add_agnt;
    sub_agent       sub_agnt;

    add_scoreboard  add_scb;
    sub_scoreboard  sub_scb;

    virtual_env_sequencer v_e_sqr;

    function new(string name ="add_sub_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        add_agnt = add_agent::type_id::create("add_agnt", this);
        sub_agnt = sub_agent::type_id::create("sub_agnt", this);
        add_scb = add_scoreboard::type_id::create("add_scb", this);
        sub_scb = sub_scoreboard::type_id::create("sub_scb", this);

        v_e_sqr = virtual_env_sequencer::type_id::create("v_e_sqr", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        add_agnt.add_mon.add_mon_port.connect(add_scb.add_scb_imp);
        sub_agnt.sub_mon.sub_mon_port.connect(sub_scb.sub_scb_imp);

        v_e_sqr.add_env_sqr_h = add_agnt.add_sqr;
        v_e_sqr.sub_env_sqr_h = sub_agnt.sub_sqr;
    endfunction: connect_phase

endclass: add_sub_env