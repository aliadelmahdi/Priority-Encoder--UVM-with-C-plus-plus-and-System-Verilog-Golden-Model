`include "encoder_defines.svh" // For macros
`timescale `TIME_UNIT / `TIME_PRECISION

module encoder_sva(
    input clk,
    input rst,
    input [3:0] D,
    input [1:0] Q,
    input valid
  );
  
  //** 1: Reset Behavior Verification **\\

  property reset_check;
     (rst) |-> (!Q && !valid);
  endproperty

  reset_assert: assert property (@(posedge clk or posedge rst) (reset_check))
    else $error("Reset Assertion failed!");

endmodule


