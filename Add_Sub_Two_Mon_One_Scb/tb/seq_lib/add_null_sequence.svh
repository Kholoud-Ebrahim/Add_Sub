class add_null_sequence extends add_base_sequence;
    `uvm_object_utils(add_null_sequence)

    add_sequence_item add_item;

    function new(string name = "add_null_sequence");
        super.new(name);
    endfunction: new

    task body();
      add_item = add_sequence_item::type_id::create("add_item");
        start_item(add_item);
        assert(add_item.randomize() with {a == 0; b == 0;});
        finish_item(add_item);
    endtask: body

endclass: add_null_sequence