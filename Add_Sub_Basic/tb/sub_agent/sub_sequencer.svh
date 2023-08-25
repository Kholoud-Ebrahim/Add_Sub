class sub_sequencer extends uvm_sequencer #(sub_sequence_item);
    `uvm_component_utils(sub_sequencer)

    function new(string name= "sub_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new
endclass: sub_sequencer