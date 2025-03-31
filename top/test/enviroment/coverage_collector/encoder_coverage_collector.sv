package encoder_coverage_pkg;
    import  uvm_pkg::*,
            encoder_driver_pkg::*,
            encoder_scoreboard_pkg::*,
            encoder_main_sequence_pkg::*,
            encoder_reset_sequence_pkg::*,
            encoder_seq_item_pkg::*,
            encoder_sequencer_pkg::*,
            encoder_monitor_pkg::*,
            encoder_config_pkg::*,
            encoder_agent_pkg::*;
    `include "uvm_macros.svh"
            `define MAX 15
            `define MID_RANGE 1:14
            

    class encoder_coverage extends uvm_component;
        `uvm_component_utils(encoder_coverage)

        // Analysis Export for receiving transactions from monitors
        uvm_analysis_export #(encoder_seq_item) encoder_cov_export;
        uvm_tlm_analysis_fifo #(encoder_seq_item) encoder_cov_enc;
        encoder_seq_item encoder_seq_item_cov;

        // Covergroup definitions
        covergroup encoder_cov_grp;
            rst_cp: coverpoint encoder_seq_item_cov.rst{
                bins active = {`HIGH};
                bins inactive = {`LOW};
                bins active_to_inactive = (`HIGH=>`LOW);
                bins inactive_to_active = (`LOW=>`HIGH);
            }
            valid_cp: coverpoint encoder_seq_item_cov.valid{
                bins VALID = {`HIGH};
                bins NOT_VALID = {`LOW};
                bins VALID_to_NOT_VALID = (`HIGH=>`LOW);
                bins NOT_VALID_to_VALID = (`LOW=>`HIGH);
            }
            input_cp: coverpoint encoder_seq_item_cov.D {
                bins ZERO = {0};
                bins MAX = {15};
                bins MID_RANGE []= {[1:14]};
            }
            output_cp: coverpoint encoder_seq_item_cov.Q {
                bins ZERO_OUT = {0};
                bins OUT []= {[0:$]};

            }
            core_cr: cross output_cp,valid_cp{
               bins output_valid =  binsof(output_cp.OUT) && binsof(valid_cp.VALID);
                bins output_not_valid  = binsof(output_cp.ZERO_OUT)  && binsof(valid_cp.NOT_VALID);
                option.cross_auto_bin_max = 0;
            }
        endgroup
 
        // Constructor
        function new (string name = "encoder_coverage", uvm_component parent);
            super.new(name, parent);
            encoder_cov_grp = new();
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            encoder_cov_export = new("encoder_cov_export", this);
            encoder_cov_enc = new("encoder_cov_enc", this);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            encoder_cov_export.connect(encoder_cov_enc.analysis_export);
        endfunction

        // Run Phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                // Get the next transaction from the analysis FIFO.
                encoder_cov_enc.get(encoder_seq_item_cov);
                encoder_cov_grp.sample();
            end
        endtask

    endclass : encoder_coverage

endpackage : encoder_coverage_pkg