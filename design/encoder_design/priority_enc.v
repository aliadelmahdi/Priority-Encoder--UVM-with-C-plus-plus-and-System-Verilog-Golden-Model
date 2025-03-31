module priority_enc (
  input clk,
  input rst,
  input [3:0] D,
  output reg [1:0] Q,
  output reg valid
);

always @(posedge clk or posedge rst) begin
  if (rst) begin
    Q <= 2'b00;
    valid <= 1'b0;
  end
  else begin
    casex (D)
      4'b0000: begin
        Q <= 2'bxx;          
        valid <= 1'b0;
      end
      4'b1xxx: begin
        Q <= 2'b11;          
        valid <= 1'b1;
      end
      4'b01xx: begin
        Q <= 2'b10;          
        valid <= 1'b1;
      end
      4'b001x: begin
        Q <= 2'b01;          
        valid <= 1'b1;
      end
      4'b0001: begin
        Q <= 2'b00;          
        valid <= 1'b1;
      end
      default: begin
        Q <= 2'b00;
        valid <= 1'b0;
      end
    endcase
  end
end

endmodule : priority_enc