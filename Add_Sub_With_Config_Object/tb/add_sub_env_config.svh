class add_sub_env_config extends uvm_object;
    `uvm_object_utils(add_sub_env_config)

    add_agent_config           add_agnt_config;
    sub_agent_config           sub_agnt_config;

    uvm_active_passive_enum    add_is_active;
    uvm_active_passive_enum    sub_is_active;

    virtual add_intf #(WIDTH) add_vif;
    virtual sub_intf #(WIDTH) sub_vif;

    function new(string name = "add_sub_env_config");
        super.new(name);
    endfunction :new
endclass :add_sub_env_config