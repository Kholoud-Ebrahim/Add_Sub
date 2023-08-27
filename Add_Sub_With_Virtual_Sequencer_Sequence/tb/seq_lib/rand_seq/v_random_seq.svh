class v_random_seq extends virtual_sequence;
    `uvm_object_utils(v_random_seq)

    function new(string name = "v_random_seq");
        super.new(name);
    endfunction :new

    task body();
        super.body();
        a_base_seq = add_base_sequence::type_id::create("a_base_seq");
        s_base_seq = sub_base_sequence::type_id::create("s_base_seq");
        
        fork
            a_base_seq.start(a_sqr);
            s_base_seq.start(s_sqr);
        join
    endtask: body 
endclass :v_random_seq