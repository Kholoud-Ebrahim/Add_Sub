class sub_agent extends uvm_agent;
    `uvm_component_utils(sub_agent)

    sub_sequencer  sub_sqr;
    sub_driver     sub_drv;
    sub_monitor    sub_mon;

    sub_agent_config           sub_agnt_config;
    uvm_active_passive_enum    is_active;

    uvm_analysis_port #(sub_sequence_item) sub_mon2agnt_port;


    function new(string name= "sub_agent", uvm_component parent);
        super.new(name, parent);

        sub_mon2agnt_port = new("sub_mon2agnt_port", this);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!(uvm_config_db #(sub_agent_config)::get(this, "", "sub_agnt_config_name", sub_agnt_config)))
            `uvm_fatal(get_full_name(), "Cannot get Agent Config from configuration database!") 

        is_active = sub_agnt_config.is_active;

        if(is_active == UVM_ACTIVE) begin
            sub_sqr = sub_sequencer::type_id::create("sub_sqr",this);
            sub_drv = sub_driver::type_id::create("sub_drv",this);
        end
        sub_mon = sub_monitor::type_id::create("sub_mon",this);
       
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    
        if(is_active == UVM_ACTIVE) begin
            sub_drv.seq_item_port.connect(sub_sqr.seq_item_export);
        end
        
        sub_mon.sub_mon_port.connect(sub_mon2agnt_port);
    endfunction: connect_phase
endclass: sub_agent