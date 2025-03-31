package encoder_env_pkg; 
    import  uvm_pkg::*,
            encoder_driver_pkg::*,
            encoder_scoreboard_pkg::*,
            encoder_main_sequence_pkg::*,
            encoder_reset_sequence_pkg::*,
            encoder_seq_item_pkg::*,
            encoder_sequencer_pkg::*,
            encoder_monitor_pkg::*,
            encoder_config_pkg::*,
            encoder_agent_pkg::*,
            encoder_coverage_pkg::*;
    `include "uvm_macros.svh"
    class encoder_env extends uvm_env;
        `uvm_component_utils(encoder_env)

        encoder_agent enc_agent;
        encoder_scoreboard enc_sb;
        encoder_coverage enc_cov;
        
        // Default Constructor
        function new (string name = "encoder_env", uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase );
        super.build_phase (phase);
            enc_agent = encoder_agent::type_id::create("enc_agent",this);
            enc_sb= encoder_scoreboard::type_id::create("enc_sb",this);
            enc_cov= encoder_coverage::type_id::create("enc_cov",this);
        endfunction

        // Connect Phase
        function void connect_phase (uvm_phase phase );
            enc_agent.enc_agent_ap.connect(enc_sb.encoder_sb_export);
            enc_agent.enc_agent_ap.connect(enc_cov.encoder_cov_export);
        endfunction

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
        endtask
    endclass : encoder_env
endpackage : encoder_env_pkg