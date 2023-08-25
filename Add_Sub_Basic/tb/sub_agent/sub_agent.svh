class sub_agent extends uvm_agent;
    `uvm_component_utils(sub_agent)

    sub_sequencer  sub_sqr;
    sub_driver     sub_drv;
    sub_monitor    sub_mon;

    function new(string name= "sub_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        sub_sqr = sub_sequencer::type_id::create("sub_sqr",this);
        sub_drv = sub_driver::type_id::create("sub_drv",this);
        sub_mon = sub_monitor::type_id::create("sub_mon",this);
       
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    
        sub_drv.seq_item_port.connect(sub_sqr.seq_item_export);
    endfunction: connect_phase
endclass: sub_agent