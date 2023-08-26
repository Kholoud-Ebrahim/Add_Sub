class sub_full_sequence extends sub_base_sequence;
  `uvm_object_utils(sub_full_sequence)

  sub_sequence_item sub_item;

  function new(string name = "sub_full_sequence");
      super.new(name);
  endfunction: new

  task body();
    sub_item = sub_sequence_item::type_id::create("sub_item");
      start_item(sub_item);
      assert(sub_item.randomize() with {x == {WIDTH{1'b1}}; y == {WIDTH{1'b1}}; x >= y;});
      finish_item(sub_item);
  endtask: body

endclass: sub_full_sequence