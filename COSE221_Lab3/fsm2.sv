/* *******************************
 *   COSE221 Lab #3
 *
 *   Author: Gunjae Koo (gunjaekoo@korea.ac.kr)
 *
 * *******************************
 */

module fsm2(
   input         clk,
   input         reset_n,   // asychronous negative reset
   input         p, r,
   input         ta, tb,
   output   [1:0]   la, lb
);

   logic         m;

   /* FILL THIS */
   fsm_mode u_fsm_mode (
      .clk     (clk),
      .reset_n (reset_n),
      .p       (p),
      .r       (r),
      .m       (m)
   );

   fsm_light u_fsm_light (
      .clk     (clk),
      .reset_n (reset_n),
      .m       (m),
      .ta      (ta),
      .tb      (tb),
      .la      (la),
      .lb      (lb)
   );

   
endmodule

module fsm_mode(
   input         clk,
   input         reset_n,   // asychronous negative reset
   input         p, r,
   output        m
);

   localparam S0 = 1'b0,
              S1 = 1'b1;

   logic         state_curr, state_next;

   // state register
   /* FILL THIS */
   always_ff @ (posedge clk or negedge reset_n) begin
      if (~reset_n) state_curr <= S0;
      else          state_curr <= state_next;
   end

   // next state logic
   /* FILL THIS */
   always_comb begin
      case (state_curr)
         S0: if (p) state_next = S1;
             else   state_next = S0;
         S1: if (r) state_next = S0;
             else   state_next = S1;
         default:   state_next = S0;
      endcase
   end

   // output logic
   /* FILL THIS */
   assign m = (state_curr==S1)? 1'b1: 1'b0;


   // synthesis translate_off
   logic [2*8-1:0] state_dbg;

   always_comb begin
      case (state_curr)
         S0: state_dbg = "S0";
         S1: state_dbg = "S1";
      endcase
   end
   // synthesis translate_on

endmodule


module fsm_light(
   input          clk,
   input          reset_n,   // asychronous negative reset
   input          m,
   input          ta, tb,
   output [1:0]   la, lb
);

   logic   [1:0]   la, lb;

   localparam S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;

   localparam GREEN = 2'b00,
              YELLOW = 2'b01,
              RED = 2'b10;

   logic [1:0]   state_curr, state_next;

   // state register
   /* FILL THIS */
   always_ff @ (posedge clk or negedge reset_n) begin
      if (~reset_n) state_curr <= S0;
      else          state_curr <= state_next;
   end

   // next state logic
   /* FILL THIS */
   always_comb begin
      case (state_curr)
         S0: if (ta)        state_next = S0;
             else           state_next = S1;
         S1:                state_next = S2;
         S2: if (m | tb)    state_next = S2;
             else           state_next = S3;
         default:           state_next = S0;
      endcase
   end

   // output logic
   /* FILL THIS */
   assign la = (state_curr == S2) ? RED :
               (state_curr == S3) ? RED :
               (state_curr == S1) ? YELLOW : GREEN;

   assign lb = (state_curr == S0) ? RED :
               (state_curr == S1) ? RED :
               (state_curr == S3) ? YELLOW : GREEN;

   // synthesis translate_off
   logic [2*8-1:0] state_dbg;

   always_comb begin
      case (state_curr)
         S0: state_dbg = "S0";
         S1: state_dbg = "S1";
         S2: state_dbg = "S2";
         S3: state_dbg = "S3";
      endcase
   end
   // synthesis translate_on

endmodule