package encoder_scoreboard_pkg;
    import  uvm_pkg::*,
            encoder_seq_item_pkg::*;
    
    `include "encoder_defines.svh" // For macros

    `include "uvm_macros.svh"
    class encoder_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(encoder_scoreboard)
        
        uvm_analysis_export #(encoder_seq_item) encoder_sb_export;
        uvm_tlm_analysis_fifo #(encoder_seq_item) enc_sb;
        encoder_seq_item encoder_seq_item_sb;


        int error_count = 0, correct_count = 0;
        
        // Default Constructor
        function new(string name = "encoder_scoreboard",uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            encoder_sb_export = new("encoder_sb_export",this);
            enc_sb=new("enc_sb",this);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            encoder_sb_export.connect(enc_sb.analysis_export);
        endfunction

        // Run Phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                enc_sb.get(encoder_seq_item_sb);
                check_results(encoder_seq_item_sb);
            end
        endtask

        // Report Phase
        function void report_phase(uvm_phase phase);
            super.report_phase(phase);
            `uvm_info("report_phase",$sformatf("At time %0t: Simulation Ends and Error count= %0d, Correct count= %0d",$time,error_count,correct_count),UVM_MEDIUM);
        endfunction

        function void check_results(encoder_seq_item seq_item_ch);
            if ( seq_item_ch.Q != seq_item_ch.Q_ref
                || seq_item_ch.valid != seq_item_ch.valid_ref
                ) begin
                error_count++;
                `uvm_error("run_phase","Comparison Error between the golden model and the DUT")
                `uvm_info("run_phase", $sformatf("Encoder Transaction:\n%s", seq_item_ch.sprint()), UVM_MEDIUM)
            end
            else
                correct_count++;
        endfunction
    endclass : encoder_scoreboard

endpackage : encoder_scoreboard_pkg