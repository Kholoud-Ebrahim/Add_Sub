`uvm_analysis_imp_decl (_add)
`uvm_analysis_imp_decl (_sub)

class add_sub_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(add_sub_scoreboard)

    add_sequence_item add_item;
    add_sequence_item add_trasaction [$];

    sub_sequence_item sub_item;
    sub_sequence_item sub_trasaction [$];

    uvm_analysis_imp_add #(add_sequence_item, add_sub_scoreboard) add_scb_imp;
    uvm_analysis_imp_sub #(sub_sequence_item, add_sub_scoreboard) sub_scb_imp;

    function new(string name= "add_sub_scoreboard", uvm_component parent);
        super.new(name, parent);

        add_scb_imp = new("add_scb_imp", this); 
        sub_scb_imp = new("sub_scb_imp", this);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase

    function void write_add(add_sequence_item add_item);
        add_trasaction.push_back(add_item);
    endfunction: write_add

    function void write_sub(sub_sequence_item sub_item);
        sub_trasaction.push_back(sub_item);
    endfunction: write_sub

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            fork
                begin
                    add_sequence_item add_current_trans;
                    wait(add_trasaction.size() != 0 );
                    add_current_trans = add_trasaction.pop_front();
                    add_compare(add_current_trans);
                end
                begin
                    sub_sequence_item sub_current_trans;
                    wait(sub_trasaction.size() != 0 );
                    sub_current_trans = sub_trasaction.pop_front();
                    sub_compare(sub_current_trans);
                end
            join
          
        end
        
    endtask: run_phase

    task add_compare(add_sequence_item add_current_trans);
        bit [WIDTH:0] expected , actual;

        expected = add_current_trans.a + add_current_trans.b ;
        
        actual = add_current_trans.add;
        
        assert(actual == expected) 
            `uvm_info("COMPARE_ADD_PASSED", $sformatf(" @%5t: a=%4d    b=%4d  Exp=%4d  Actual=%4d", $time, add_current_trans.a, add_current_trans.b, expected, actual), UVM_LOW)
        else
            `uvm_error("COMPARE_ADD_FAILED", $sformatf("@%5t: a=%4d    b=%4d  Exp=%4d  Actual=%4d", $time, add_current_trans.a, add_current_trans.b, expected, actual))
        
    endtask:add_compare

    task sub_compare(sub_sequence_item sub_current_trans);
        logic [WIDTH:0] expected , actual;
        
        expected = sub_current_trans.x - sub_current_trans.y;
        
        actual = sub_current_trans.sub;
        
        assert(actual == expected) 
            `uvm_info("COMPARE_SUB_PASSED", $sformatf("@%5t: x=%4d    y=%4d  Exp=%4d  Actual=%4d", $time, sub_current_trans.x, sub_current_trans.y, expected, actual), UVM_LOW)
        else
            `uvm_error("COMPARE_SUB_FAILED", $sformatf("@%5t: x=%4d    y=%4d  Exp=%4d  Actual=%4d", $time, sub_current_trans.x, sub_current_trans.y, expected, actual))
                    
    endtask:sub_compare
    
endclass: add_sub_scoreboard