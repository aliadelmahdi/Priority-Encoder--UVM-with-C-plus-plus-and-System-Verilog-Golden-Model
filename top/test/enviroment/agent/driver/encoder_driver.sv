package encoder_driver_pkg;

    import  uvm_pkg::*,
            encoder_config_pkg::*,
            encoder_main_sequence_pkg::*,
            encoder_reset_sequence_pkg::*,
            encoder_seq_item_pkg::*;
    `include "uvm_macros.svh"

    class encoder_driver extends uvm_driver #(encoder_seq_item);
        `uvm_component_utils(encoder_driver)
        virtual encoder_if e_if;
        encoder_seq_item stimulus_seq_item;

        // Default Constructor
        function new(string name = "encoder_driver", uvm_component parent);
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
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                stimulus_seq_item = encoder_seq_item::type_id::create("encoder_stimulus_seq_item");
                seq_item_port.get_next_item(stimulus_seq_item);
                e_if.D = stimulus_seq_item.D;
                e_if.rst = stimulus_seq_item.rst;
                @(negedge e_if.clk)
                seq_item_port.item_done();
                `uvm_info("run_phase",stimulus_seq_item.sprint(),UVM_HIGH)
            end
        endtask
        
    endclass : encoder_driver

endpackage : encoder_driver_pkg