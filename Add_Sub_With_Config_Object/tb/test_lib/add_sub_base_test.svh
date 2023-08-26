class add_sub_base_test extends uvm_test;
    `uvm_component_utils (add_sub_base_test)

    add_sub_env               env; 
    add_sub_env_config        env_config;

    uvm_active_passive_enum   a_is_active;
    uvm_active_passive_enum   s_is_active;

    virtual add_intf #(WIDTH) add_env_vif;
    virtual sub_intf #(WIDTH) sub_env_vif;
    
    function new(string name = "add_sub_base_test", uvm_component parent);
        super.new(name, parent);
    endfunction
        
        
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        env = add_sub_env::type_id::create ("env", this); 
        env_config = add_sub_env_config::type_id::create ("env_config");
        
        if(!(uvm_config_db #(virtual add_intf#(WIDTH))::get(this, "", "add_vif", add_env_vif)))
            `uvm_fatal(get_full_name(), "Cannot get Add VIF from configuration database!")
        
        if(!(uvm_config_db #(virtual sub_intf#(WIDTH))::get(this, "", "sub_vif", sub_env_vif)))
            `uvm_fatal(get_full_name(), "Cannot get Sub VIF from configuration database!")

        env_config.add_vif       = add_env_vif;
        env_config.sub_vif       = sub_env_vif;

        a_is_active = UVM_ACTIVE;
        s_is_active = UVM_ACTIVE;

        env_config.add_is_active = a_is_active;
        env_config.sub_is_active = s_is_active;

        uvm_config_db #(add_sub_env_config)::set(this, "*", "env_config_name", env_config);

    endfunction
        
    //Printing the heirarchy of the TB components	
    function void end_of_elaboration_phase (uvm_phase phase);
        uvm_top.print_topology();
    endfunction
        
endclass :add_sub_base_test