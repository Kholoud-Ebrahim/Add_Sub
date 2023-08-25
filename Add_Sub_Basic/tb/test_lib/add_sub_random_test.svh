class add_sub_random_test extends add_sub_base_test;
	`uvm_component_utils (add_sub_random_test)

	add_base_sequence   add_seq;
	sub_base_sequence   sub_seq;

	function new(string name = "add_sub_random_test", uvm_component parent);
    	super.new(name, parent);
	endfunction
	
	function void build_phase (uvm_phase phase);	
		super.build_phase(phase);

		add_seq = add_base_sequence::type_id::create("add_seq", this);
		sub_seq = sub_base_sequence::type_id::create("sub_seq", this);
	endfunction
	
	task run_phase (uvm_phase phase);	
		super.run_phase(phase);
		
		phase.raise_objection(this);
			
			repeat(20) begin
				fork
				add_seq.start(env.add_agnt.add_sqr);
				sub_seq.start(env.sub_agnt.sub_sqr);
				join	
			end
			#(CLK_PERIOD);
		phase.drop_objection(this);
		
	endtask
endclass :add_sub_random_test