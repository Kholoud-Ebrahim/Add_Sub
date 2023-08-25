class sub_null_sequence extends sub_base_sequence;
  `uvm_object_utils(sub_null_sequence)

  sub_sequence_item sub_item;

  function new(string name = "sub_null_sequence");
      super.new(name);
  endfunction: new

  task body();
    sub_item = sub_sequence_item::type_id::create("sub_item");
      start_item(sub_item);
      assert(sub_item.randomize() with {x == 0; y == 0; x >= y;});
      finish_item(sub_item);
  endtask: body

endclass: sub_null_sequence