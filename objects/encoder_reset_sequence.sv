package encoder_reset_sequence_pkg;

    import uvm_pkg::*,
           encoder_seq_item_pkg::*;
    `include "uvm_macros.svh"
           
    class encoder_reset_sequence extends uvm_sequence #(encoder_seq_item);

        `uvm_object_utils (encoder_reset_sequence)
        encoder_seq_item seq_item;

        function new (string name = "encoder_reset_sequence");
            super.new(name);
        endfunction

        task body;
            seq_item = encoder_seq_item::type_id::create("seq_item");
            start_item(seq_item);
                seq_item.rst = `LOW;
                seq_item.D = `LOW;
            finish_item(seq_item);
        endtask
        
    endclass : encoder_reset_sequence

endpackage : encoder_reset_sequence_pkg