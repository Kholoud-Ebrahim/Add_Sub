class add_sub_base_test extends uvm_test;
    `uvm_component_utils (add_sub_base_test)

    add_sub_env     env; 

    v_random_seq    v_random_seq_h;
    v_full_seq      v_full_seq_h;
    v_null_seq      v_null_seq_h;
    
    function new(string name = "add_sub_base_test", uvm_component parent);
        super.new(name, parent);
    endfunction
        
        
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        env = add_sub_env::type_id::create ("env", this); 
            
    endfunction
        
    //Printing the heirarchy of the TB components	
    function void end_of_elaboration_phase (uvm_phase phase);
        uvm_top.print_topology();
    endfunction
        
endclass :add_sub_base_test