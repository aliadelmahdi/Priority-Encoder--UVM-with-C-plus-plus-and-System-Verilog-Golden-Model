package encoder_monitor_pkg;

    import uvm_pkg::*,
           encoder_seq_item_pkg::*;
    `include "uvm_macros.svh"

    class encoder_monitor extends uvm_monitor;
        `uvm_component_utils (encoder_monitor)
        virtual encoder_if e_if;
        encoder_seq_item response_seq_item;
        uvm_analysis_port #(encoder_seq_item) monitor_ap;

        function new(string name = "encoder_monitor",uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            monitor_ap = new ("monitor_ap",this);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
		endfunction

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            forever begin
                response_seq_item = encoder_seq_item::type_id::create("response_seq_item");
                @(negedge e_if.clk);
                response_seq_item.rst = e_if.rst;
                response_seq_item.D = e_if.D;
                response_seq_item.Q = e_if.Q;
                response_seq_item.valid = e_if.valid;
                response_seq_item.Q_ref = e_if.Q_ref;
                response_seq_item.valid_ref = e_if.valid_ref;
                monitor_ap.write(response_seq_item);
                `uvm_info("run_phase", response_seq_item.sprint(), UVM_HIGH)
            end

        endtask
        
    endclass : encoder_monitor

endpackage : encoder_monitor_pkg