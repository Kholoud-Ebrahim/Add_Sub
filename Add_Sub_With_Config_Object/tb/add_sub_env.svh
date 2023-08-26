class add_sub_env extends uvm_env;
    `uvm_component_utils(add_sub_env)

    add_agent       add_agnt;
    sub_agent       sub_agnt;

    add_scoreboard  add_scb;
    sub_scoreboard  sub_scb;

    add_sub_env_config    env_config;
    add_agent_config      add_config;
    sub_agent_config      sub_config;


    function new(string name ="add_sub_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(add_sub_env_config)::get(this, "", "env_config_name",env_config )))
            `uvm_fatal(get_full_name(), "Cannot get Env Config from configuration database!")
        
        // set add agent config
        add_config = add_agent_config::type_id::create("add_config");
        add_config.add_vif   = env_config.add_vif;
        add_config.is_active = env_config.add_is_active;
        uvm_config_db #(add_agent_config)::set(this, "*", "add_agnt_config_name", add_config);

        // set sub agent config
        sub_config = sub_agent_config::type_id::create("sub_config");
        sub_config.sub_vif   = env_config.sub_vif;
        sub_config.is_active = env_config.sub_is_active;
        uvm_config_db #(sub_agent_config)::set(this, "*", "sub_agnt_config_name", sub_config);

        add_agnt = add_agent::type_id::create("add_agnt", this);
        sub_agnt = sub_agent::type_id::create("sub_agnt", this);
        add_scb = add_scoreboard::type_id::create("add_scb", this);
        sub_scb = sub_scoreboard::type_id::create("sub_scb", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        add_agnt.add_mon2agnt_port.connect(add_scb.add_scb_imp);
        sub_agnt.sub_mon2agnt_port.connect(sub_scb.sub_scb_imp);
    endfunction: connect_phase

endclass: add_sub_env