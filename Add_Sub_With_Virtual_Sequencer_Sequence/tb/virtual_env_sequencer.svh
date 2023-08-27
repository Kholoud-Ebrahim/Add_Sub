class virtual_env_sequencer extends uvm_sequencer #(uvm_sequence_item);
    `uvm_component_utils(virtual_env_sequencer)

    add_sequencer    add_env_sqr_h;
    sub_sequencer    sub_env_sqr_h;

    function new(string name = "virtual_env_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction :new
    
endclass :virtual_env_sequencer