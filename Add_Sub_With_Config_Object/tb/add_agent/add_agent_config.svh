class add_agent_config extends uvm_object;
    `uvm_object_utils(add_agent_config)

    virtual add_intf #(WIDTH)        add_vif;
    uvm_active_passive_enum  is_active;

    function new(string name= "add_agent_config");
        super.new(name);
    endfunction :new
endclass :add_agent_config