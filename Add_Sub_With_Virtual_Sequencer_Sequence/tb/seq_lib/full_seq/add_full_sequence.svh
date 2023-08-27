class add_full_sequence extends add_base_sequence;
    `uvm_object_utils(add_full_sequence)

    add_sequence_item add_item;

    function new(string name = "add_full_sequence");
        super.new(name);
    endfunction: new

    task body();
      add_item = add_sequence_item::type_id::create("add_item");
        start_item(add_item);
        assert(add_item.randomize() with {a == {WIDTH{1'b1}}; b == {WIDTH{1'b1}};});
        finish_item(add_item);
    endtask: body

endclass: add_full_sequence