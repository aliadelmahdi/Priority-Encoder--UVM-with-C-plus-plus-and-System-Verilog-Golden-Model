import uvm_pkg::*;
import encoder_env_pkg::*;
import encoder_test_pkg::*;
`include "encoder_defines.svh" // For macros
`timescale `TIME_UNIT / `TIME_PRECISION

module tb_top;
    bit clk;
    // Clock Generation
    initial begin
        clk = `LOW;
        forever #(`CLK_PERIOD/2) clk = ~ clk;
    end

    
    encoder_env env_instance;
    encoder_test test;

    encoder_if e_if (clk);
    priority_enc DUT (
        .clk(e_if.clk),
        .rst(e_if.rst),
        .D(e_if.D),
        .Q(e_if.Q),
        .valid(e_if.valid)
        );

    golden_model GLD (
        .clk(e_if.clk),
        .rst(e_if.rst),
        .D(e_if.D),
        .Q(e_if.Q_ref),
        .valid(e_if.valid_ref)
        );



    bind priority_enc encoder_sva encoder_sva_inst (
        .clk(e_if.clk),
        .rst(e_if.rst),
        .D(e_if.D),
        .Q(e_if.Q),
        .valid(e_if.valid)
        );    

    initial begin
        uvm_top.set_report_verbosity_level(UVM_MEDIUM); // Set verbosity level
        uvm_top.finish_on_completion = `DISABLE_FINISH; // Prevent UVM from calling $finish
        uvm_config_db#(virtual encoder_if)::set(null, "*", "e_if", e_if); // Set encoder interface globally
        run_test("encoder_test"); // Start the UVM test
        $stop; // Stop simulation after test execution
    end
endmodule : tb_top