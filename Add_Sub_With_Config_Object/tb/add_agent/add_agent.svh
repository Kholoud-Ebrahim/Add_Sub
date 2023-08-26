class add_agent extends uvm_agent;
    `uvm_component_utils(add_agent)

    add_sequencer  add_sqr;
    add_driver     add_drv;
    add_monitor    add_mon;

    add_agent_config                        add_agnt_config;
    uvm_active_passive_enum                 is_active;

    uvm_analysis_port #(add_sequence_item)  add_mon2agnt_port;

    function new(string name= "add_agent", uvm_component parent);
        super.new(name, parent);

        add_mon2agnt_port = new("add_mon2agnt_port", this);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(! (uvm_config_db #(add_agent_config)::get(this, "", "add_agnt_config_name",add_agnt_config)))
            `uvm_fatal(get_full_name(), "Cannot get Agent Config from configuration database!")

        is_active = add_agnt_config.is_active;
        
        if(is_active == UVM_ACTIVE) begin
            add_sqr = add_sequencer::type_id::create("add_sqr",this);
            add_drv = add_driver::type_id::create("add_drv",this);
        end

        add_mon = add_monitor::type_id::create("add_mon",this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        if(is_active == UVM_ACTIVE) begin
            add_drv.seq_item_port.connect(add_sqr.seq_item_export);
        end
        add_mon.add_mon_port.connect(add_mon2agnt_port);
    endfunction: connect_phase
endclass: add_agent