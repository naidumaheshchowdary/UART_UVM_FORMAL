//Clk_freq = 50MHZ, baud rate = 9600
module Baudrate_generator #(parameter Clk_freq = 50_000_000,
                            parameter BD = 9600)
  (
    input logic clk,rst_n,
    output logic tx_enb, rx_enb
  );
  // ─── Calculated Constants ────────────────────────────

  localparam tx_cnt_val = Clk_freq/BD;          // 5208
  localparam rx_cnt_val = Clk_freq/(16*BD);     // 325

  // ─── Correct Bit Widths ──────────────────────────────
  localparam TX_W = $clog2(tx_cnt_val);  // 13 bits
  localparam RX_W = $clog2(rx_cnt_val);  // 9 bits

  
  logic [TX_W-1:0] counter_tx; // 13 bits
  logic [RX_W-1:0] counter_rx; //9 bits

  // Fix:
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) counter_tx <= '0;    // known clean start 
    else if (tx_start) counter_tx <= '0;     // resync counter to tx_start 
    else if (counter_tx == tx_cnt_val - 1) counter_tx <= '0;
    else counter_tx <= counter_tx + 1'b1;
  end

  always_ff @(posedge clk or negedge rst_n) begin 
    if(!rst_n) counter_rx <= '0;
    else if (counter_rx == rx_cnt_val -1) counter_rx <= '0;
    else counter_rx <= counter_rx + 1'b1;
  end

  assign tx_enb = (counter_tx == tx_cnt_val -1)? 1'b1:1'b0;
  assign rx_enb = (counter_rx == rx_cnt_val-1)? 1'b1:1'b0;

endmodule

