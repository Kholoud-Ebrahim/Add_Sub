class add_agent extends uvm_agent;
    `uvm_component_utils(add_agent)

    add_sequencer  add_sqr;
    add_driver     add_drv;
    add_monitor    add_mon;

    function new(string name= "add_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        add_sqr = add_sequencer::type_id::create("add_sqr",this);
        add_drv = add_driver::type_id::create("add_drv",this);
        add_mon = add_monitor::type_id::create("add_mon",this);
       
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    
        add_drv.seq_item_port.connect(add_sqr.seq_item_export);
    endfunction: connect_phase
endclass: add_agent