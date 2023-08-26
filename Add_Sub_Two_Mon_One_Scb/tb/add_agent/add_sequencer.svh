class add_sequencer extends uvm_sequencer #(add_sequence_item);
    `uvm_component_utils(add_sequencer)

    function new(string name= "add_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new
endclass: add_sequencer