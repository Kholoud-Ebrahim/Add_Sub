class add_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(add_scoreboard)

    add_sequence_item add_item;
    add_sequence_item add_trasaction [$];

    uvm_analysis_imp #(add_sequence_item, add_scoreboard) add_scb_imp;

    function new(string name= "add_scoreboard", uvm_component parent);
        super.new(name, parent);

        add_scb_imp = new("add_scb_imp", this); 
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase

    function void write(add_sequence_item add_item);
        add_trasaction.push_back(add_item);
    endfunction: write

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
          add_sequence_item add_current_trans;
          wait(add_trasaction.size() != 0 );
          add_current_trans = add_trasaction.pop_front();
          compare(add_current_trans);
        end
        
    endtask: run_phase

    task compare(add_sequence_item add_current_trans);
        bit [WIDTH:0] expected , actual;

        expected = add_current_trans.a + add_current_trans.b ;
        
        actual = add_current_trans.add;
        
        assert(actual == expected) 
            `uvm_info("COMPARE_ADD_PASSED", $sformatf(" @%5t: a=%4d    b=%4d  Exp=%4d  Actual=%4d", $time, add_current_trans.a, add_current_trans.b, expected, actual), UVM_LOW)
        else
            `uvm_error("COMPARE_ADD_FAILED", $sformatf("@%5t: a=%4d    b=%4d  Exp=%4d  Actual=%4d", $time, add_current_trans.a, add_current_trans.b, expected, actual))
        
    endtask:compare
    
endclass: add_scoreboard