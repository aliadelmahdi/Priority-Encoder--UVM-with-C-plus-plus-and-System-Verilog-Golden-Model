package encoder_agent_pkg;
    import  uvm_pkg::*,
            encoder_seq_item_pkg::*,
            encoder_driver_pkg::*,
            encoder_main_sequence_pkg::*,
            encoder_reset_sequence_pkg::*,
            encoder_sequencer_pkg::*,
            encoder_monitor_pkg::*,
            encoder_config_pkg::*;
    `include "uvm_macros.svh"
 
    class encoder_agent extends uvm_agent;

        `uvm_component_utils(encoder_agent)
        encoder_sequencer enc_seqr;
        encoder_driver enc_drv;
        encoder_monitor enc_mon;
        encoder_config enc_cnfg;
        uvm_analysis_port #(encoder_seq_item) enc_agent_ap;

        // Default Constructor
        function new(string name = "encoder_agent", uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            if(!uvm_config_db #(encoder_config)::get(this,"","CFG",enc_cnfg)) 
                `uvm_fatal ("build_phase","Unable to get the encoder configuration object from the database")
            
            enc_drv = encoder_driver::type_id::create("enc_drv",this);
            enc_seqr = encoder_sequencer::type_id::create("enc_seqr",this);
            enc_mon = encoder_monitor::type_id::create("enc_mon",this);
            enc_agent_ap = new("enc_agent_ap",this);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
            enc_drv.e_if = enc_cnfg.e_if;
            enc_mon.e_if = enc_cnfg.e_if;
            enc_drv.seq_item_port.connect(enc_seqr.seq_item_export);
            enc_mon.monitor_ap.connect(enc_agent_ap);
        endfunction

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
        endtask
    endclass : encoder_agent

endpackage : encoder_agent_pkg