class sub_sequence_item extends uvm_sequence_item;
    rand bit [WIDTH-1:0] x;
    rand bit [WIDTH-1:0] y;

    bit [WIDTH:0] sub;

    `uvm_object_utils_begin(sub_sequence_item)
        `uvm_field_int(x, UVM_DEFAULT | UVM_DEC)
        `uvm_field_int(y, UVM_DEFAULT | UVM_DEC)
        `uvm_field_int(sub, UVM_DEFAULT | UVM_DEC)
    `uvm_object_utils_end

    function new(string name = "sub_sequence_item");
        super.new(name);
    endfunction: new

endclass: sub_sequence_item