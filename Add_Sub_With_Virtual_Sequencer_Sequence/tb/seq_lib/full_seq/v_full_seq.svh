class v_full_seq extends virtual_sequence;
    `uvm_object_utils(v_full_seq)

    function new(string name = "v_full_seq");
        super.new(name);
    endfunction :new

    task body();
        super.body();

        a_full_seq = add_full_sequence::type_id::create("a_full_seq");
        s_full_seq = sub_full_sequence::type_id::create("s_full_seq");

        fork
            a_full_seq.start(a_sqr);
            s_full_seq.start(s_sqr);
        join
    endtask :body
endclass :v_full_seq