class virtual_sequence extends uvm_sequence #(uvm_sequence_item);
    `uvm_object_utils(virtual_sequence)

    virtual_env_sequencer    v_sqr;

    add_sequencer            a_sqr;
    sub_sequencer            s_sqr;
    
    add_base_sequence        a_base_seq;
    sub_base_sequence        s_base_seq;

    add_full_sequence        a_full_seq;
    sub_full_sequence        s_full_seq;

    add_null_sequence        a_null_seq;
    sub_null_sequence        s_null_seq;

    function new(string name = "virtual_sequence");
        super.new(name);
    endfunction :new

    task body();
        if( !$cast(v_sqr, m_sequencer)) 
            `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")
        
        a_sqr = v_sqr.add_env_sqr_h;
        s_sqr = v_sqr.sub_env_sqr_h;

    endtask: body    

endclass :virtual_sequence