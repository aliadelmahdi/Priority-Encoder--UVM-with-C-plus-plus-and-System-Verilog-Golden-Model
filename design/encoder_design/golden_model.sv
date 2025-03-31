import "DPI-C" function void golden_model_f(input int D, output int Q, output int valid);

module golden_model(
    input logic clk, rst,
    input logic [3:0] D,
    output logic [1:0] Q,
    output logic valid
);

    int Q_int, valid_int;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Q <= 0;
            valid <= 0;
        end else begin
            golden_model_f(D, Q_int, valid_int);
            Q <= Q_int[1:0];
            valid <= valid_int;
        end
    end

endmodule