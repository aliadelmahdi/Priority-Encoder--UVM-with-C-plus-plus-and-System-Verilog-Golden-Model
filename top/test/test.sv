
package encoder_test_pkg;
    import  uvm_pkg::*,
            encoder_env_pkg::*,
            encoder_config_pkg::*,
            encoder_driver_pkg::*,
            encoder_main_sequence_pkg::*,
            encoder_reset_sequence_pkg::*,
            encoder_seq_item_pkg::*;
    `include "uvm_macros.svh"
    class encoder_test extends uvm_test;
        `uvm_component_utils(encoder_test)
        encoder_env enc_env; // Enviroment handle to the encoder
        encoder_config enc_cnfg; // encoder configuration
        virtual encoder_if e_if; // Virtual interface handle
        encoder_main_sequence enc_main_seq; // encoder main test sequence
        encoder_reset_sequence enc_reset_seq; // encoder reset test sequence

        // Default constructor
        function new(string name = "encoder_test", uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase); // Call parent class's build_phase
            // Create instances from the UVM factory
            enc_env = encoder_env::type_id::create("env",this);
            enc_cnfg = encoder_config::type_id::create("encoder_config",this);
            enc_main_seq = encoder_main_sequence::type_id::create("encoder_main_seq",this);
            enc_reset_seq = encoder_reset_sequence::type_id::create("reset_seq",this);

            // Retrieve the virtual interface for encoder encoder from the UVM configuration database
            if(!uvm_config_db #(virtual encoder_if)::get(this,"","e_if",enc_cnfg.e_if))  
                `uvm_fatal("build_phase" , " test - Unable to get the encoder virtual interface of the encoder form the configuration database");
        
            uvm_config_db # (encoder_config)::set(this , "*" , "CFG",enc_cnfg);
        endfunction

        // Run Phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase); // Call parent class's run phase
            phase.raise_objection(this); // Raise an objection to prevent the test from ending
            // Reset sequence
            `uvm_info("run_phase","stimulus Generation started",UVM_LOW)
            enc_reset_seq.start(enc_env.enc_agent.enc_seqr);
            `uvm_info("run_phase","Reset Deasserted",UVM_LOW)
            // Main Sequence
            `uvm_info("run_phase", "Stimulus Generation Started",UVM_LOW)
            enc_main_seq.start(enc_env.enc_agent.enc_seqr);
            `uvm_info("run_phase", "Stimulus Generation Ended",UVM_LOW) 

            phase.drop_objection(this); // Drop the objection to allow the test to complete
        endtask

    endclass : encoder_test
    
endpackage : encoder_test_pkg