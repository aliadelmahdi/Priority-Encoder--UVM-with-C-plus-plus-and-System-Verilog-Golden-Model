package encoder_main_sequence_pkg;

    import uvm_pkg::*,
           encoder_seq_item_pkg::*;
    `include "uvm_macros.svh"
    `include "encoder_defines.svh" // For macros

    class encoder_main_sequence extends uvm_sequence #(encoder_seq_item);

        `uvm_object_utils (encoder_main_sequence);
        encoder_seq_item seq_item;

        function new(string name = "encoder_main_sequence");
            super.new(name);            
        endfunction
        
        task body;

            repeat(`TEST_ITER_SMALL) begin
                seq_item = encoder_seq_item::type_id::create("seq_item");
                start_item(seq_item);
                assert(seq_item.randomize()) else $error("Master Randomization Failed");
                finish_item(seq_item);
            end

        endtask
        
    endclass : encoder_main_sequence

endpackage : encoder_main_sequence_pkg