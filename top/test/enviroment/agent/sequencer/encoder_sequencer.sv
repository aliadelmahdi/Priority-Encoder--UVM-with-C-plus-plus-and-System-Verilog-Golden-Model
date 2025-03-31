package encoder_sequencer_pkg;

    import uvm_pkg::*,
           encoder_seq_item_pkg::*;
    `include "uvm_macros.svh"

    class encoder_sequencer extends uvm_sequencer #(encoder_seq_item);

        `uvm_component_utils(encoder_sequencer);

        function new(string name = "encoder_sequence", uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
		endfunction

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
        endtask
    endclass : encoder_sequencer

endpackage : encoder_sequencer_pkg