class add_sequence_item extends uvm_sequence_item;
    rand bit [WIDTH-1:0] a;
    rand bit [WIDTH-1:0] b;

    bit [WIDTH:0] add;

    `uvm_object_utils_begin(add_sequence_item)
        `uvm_field_int(a, UVM_DEFAULT | UVM_DEC)
        `uvm_field_int(b, UVM_DEFAULT | UVM_DEC)
        `uvm_field_int(add, UVM_DEFAULT | UVM_DEC)
    `uvm_object_utils_end

    function new(string name = "add_sequence_item");
        super.new(name);
    endfunction: new

endclass: add_sequence_item