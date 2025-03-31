interface encoder_if(input bit clk);
    logic rst;
    logic [3:0] D;
    logic [1:0] Q;
    logic valid;

    logic [1:0] Q_ref;
    logic valid_ref;
endinterface
