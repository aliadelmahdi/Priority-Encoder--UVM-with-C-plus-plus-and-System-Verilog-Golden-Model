package encoder_config_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class encoder_config extends uvm_object;

        `uvm_object_utils (encoder_config)
        virtual encoder_if e_if;

        // Default Constructor
        function new(string name = "encoder_config");
            super.new(name);
        endfunction
        
    endclass : encoder_config

endpackage : encoder_config_pkg