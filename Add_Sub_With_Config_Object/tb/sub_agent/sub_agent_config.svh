class sub_agent_config extends uvm_object;
    `uvm_object_utils(sub_agent_config)

    virtual sub_intf #(WIDTH)           sub_vif;
    uvm_active_passive_enum     is_active;

    function new(string name = "sub_agent_config");
      super.new(name);
    endfunction
    
endclass :sub_agent_config