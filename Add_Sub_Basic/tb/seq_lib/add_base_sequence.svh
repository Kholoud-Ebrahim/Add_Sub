class add_base_sequence extends uvm_sequence #(add_sequence_item);
    `uvm_object_utils(add_base_sequence)

    add_sequence_item add_item;

    function new(string name = "add_base_sequence");
        super.new(name);
    endfunction: new

    task body();
      add_item = add_sequence_item::type_id::create("add_item");
        start_item(add_item);
        assert(add_item.randomize());
        finish_item(add_item);
    endtask: body

endclass: add_base_sequence
