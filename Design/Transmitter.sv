module Transmitter #()
  (
    input logic clk, rst_n,
    input logic wr_enb,
    input logic [7:0] data_in,
    output logic tx, busy
  );
  
  typedef enum logic [1:0] {Idle = 0, Start =1, Data = 2, Stop = 3} states;

  states CS, NS;
  logic [7:0] data;
  logic [2:0] index;
  
  always_ff @(posedge clk or negedge rst_n) begin 
    if( !rst_n) begin
      tx = 1'b1;
    end
  end

  always_comb 
  always_ff @(posedge clk or negedge rst_n) begin 
    CS <= idle;
    case (CS)
  end
endmodule
