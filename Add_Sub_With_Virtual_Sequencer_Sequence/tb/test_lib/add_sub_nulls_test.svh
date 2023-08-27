class add_sub_nulls_test extends add_sub_base_test;
	`uvm_component_utils (add_sub_nulls_test)
 

	function new(string name = "add_sub_nulls_test", uvm_component parent);
    	super.new(name, parent);
	endfunction
	
	function void build_phase (uvm_phase phase);	
		super.build_phase(phase);

		v_null_seq_h = v_null_seq::type_id::create("v_null_seq_h", this);
	endfunction
	
	task run_phase (uvm_phase phase);	
		super.run_phase(phase);
		
		phase.raise_objection(this);
			repeat(10) begin
				v_null_seq_h.start(env.v_e_sqr);	
			end
			#(CLK_PERIOD);
		phase.drop_objection(this);
	
	endtask
endclass :add_sub_nulls_test