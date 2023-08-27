class sub_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(sub_scoreboard)

    sub_sequence_item sub_item;
    sub_sequence_item sub_trasaction [$];
    uvm_analysis_imp #(sub_sequence_item, sub_scoreboard) sub_scb_imp;

    function new(string name= "sub_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        sub_scb_imp = new("sub_scb_imp", this); 
    endfunction: build_phase

    function void write(sub_sequence_item sub_item);
        sub_trasaction.push_back(sub_item);
    endfunction: write

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
          sub_sequence_item sub_current_trans;
          wait(sub_trasaction.size() != 0 );
          sub_current_trans = sub_trasaction.pop_front();
          compare(sub_current_trans);
        end
        
    endtask: run_phase

    task compare(sub_sequence_item sub_current_trans);
        logic [WIDTH:0] expected , actual;
        
        expected = sub_current_trans.x - sub_current_trans.y;
        
        actual = sub_current_trans.sub;
        
        assert(actual == expected) 
            `uvm_info("COMPARE_SUB_PASSED", $sformatf("@%5t: x=%4d    y=%4d  Exp=%4d  Actual=%4d", $time, sub_current_trans.x, sub_current_trans.y, expected, actual), UVM_LOW)
        else
            `uvm_error("COMPARE_SUB_FAILED", $sformatf("@%5t: x=%4d    y=%4d  Exp=%4d  Actual=%4d", $time, sub_current_trans.x, sub_current_trans.y, expected, actual))
                    
    endtask:compare
   
endclass: sub_scoreboard