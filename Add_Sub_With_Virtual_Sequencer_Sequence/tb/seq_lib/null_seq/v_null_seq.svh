class v_null_seq extends virtual_sequence;
    `uvm_object_utils(v_null_seq)

    function new(string name = "v_null_seq");
        super.new(name);
    endfunction :new

    task body();
        super.body();

        a_null_seq = add_null_sequence::type_id::create("a_null_seq");
        s_null_seq = sub_null_sequence::type_id::create("s_null_seq");

        fork
            a_null_seq.start(a_sqr);
            s_null_seq.start(s_sqr);
        join
    endtask :body
endclass :v_null_seq