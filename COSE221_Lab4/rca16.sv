/* *******************************
 *	COSE221 Lab #4
 *
 *	Author: Gunjae Koo (gunjaekoo@korea.ac.kr)
 *
 * *******************************
 */

`timescale 1ns/1ps
// full adder (structural module)
module fadd (
	input	logic	a, b, cin,
	output	logic	s, cout
);

	logic 	[3:0]	n;	// internal nodes

	// sum: s = (a ^ b) ^ cin
	/* FILL THIS */
	xor2 xor2_ab      (a, b, n[0]);
    xor2 xor2_s   	  (n[0], cin, s);
	
	// cout: cout = (a*b) + (a*cin) + (b*cin)
	/* FILL THIS */
	and2 and2_ab      (a, b, n[1]);
	and2 and2_acin    (a, cin, n[2]);
	and2 and2_bcin    (b, cin, n[3]);
	or3 or3_cout      (n[1], n[2], n[3], cout);
   

endmodule

module rca16 (
	input					clk, rst_b,
	input	logic [15:0]	a, b, 
	input	logic			cin,
	output	logic [15:0]	s,
	output	logic			cout
);

	// registers for input signals
	logic	[15:0]	a_q, b_q;
	logic			cin_q;

	// t_pcq of D flip-flop is 0.010 ns
	always_ff @ (posedge clk or negedge rst_b) begin
		if (~rst_b) begin
			a_q <= 'b0;
			b_q <= 'b0;
			cin_q <= 'b0;
		end else begin
			a_q <= #(0.010) a;
			b_q <= #(0.010) b;
			cin_q <= #(0.010) cin;
		end
	end

	logic 	[15:0]	c;		// internal nodes (carry)
	logic	[15:0]	s_w;	// sum (output of an adder)

	fadd	u_fadd_0	(.a(a_q[0]), .b(b_q[0]), .cin(cin_q), .s(s_w[0]), .cout(c[0])      );
	/* FILL THIS */
	

	fadd	u_fadd_1	(.a(a_q[1]), .b(b_q[1]), .cin(c[0]), .s(s_w[1]), .cout(c[1])      );
	fadd	u_fadd_2	(.a(a_q[2]), .b(b_q[2]), .cin(c[1]), .s(s_w[2]), .cout(c[2])      );
	fadd	u_fadd_3	(.a(a_q[3]), .b(b_q[3]), .cin(c[2]), .s(s_w[3]), .cout(c[3])      );
	fadd	u_fadd_4	(.a(a_q[4]), .b(b_q[4]), .cin(c[3]), .s(s_w[4]), .cout(c[4])      );
	fadd	u_fadd_5	(.a(a_q[5]), .b(b_q[5]), .cin(c[4]), .s(s_w[5]), .cout(c[5])      );
	fadd	u_fadd_6	(.a(a_q[6]), .b(b_q[6]), .cin(c[5]), .s(s_w[6]), .cout(c[6])      );
	fadd	u_fadd_7	(.a(a_q[7]), .b(b_q[7]), .cin(c[6]), .s(s_w[7]), .cout(c[7])      );
	fadd	u_fadd_8	(.a(a_q[8]), .b(b_q[8]), .cin(c[7]), .s(s_w[8]), .cout(c[8])      );
	fadd	u_fadd_9	(.a(a_q[9]), .b(b_q[9]), .cin(c[8]), .s(s_w[9]), .cout(c[9])      );
	fadd	u_fadd_10	(.a(a_q[10]), .b(b_q[10]), .cin(c[9]), .s(s_w[10]), .cout(c[10])      );
	fadd	u_fadd_11	(.a(a_q[11]), .b(b_q[11]), .cin(c[10]), .s(s_w[11]), .cout(c[11])      );
	fadd	u_fadd_12	(.a(a_q[12]), .b(b_q[12]), .cin(c[11]), .s(s_w[12]), .cout(c[12])      );
	fadd	u_fadd_13	(.a(a_q[13]), .b(b_q[13]), .cin(c[12]), .s(s_w[13]), .cout(c[13])      );
	fadd	u_fadd_14	(.a(a_q[14]), .b(b_q[14]), .cin(c[13]), .s(s_w[14]), .cout(c[14])      );
	fadd	u_fadd_15	(.a(a_q[15]), .b(b_q[15]), .cin(c[14]), .s(s_w[15]), .cout(c[15])      );


	// registers for output signals
	always_ff @ (posedge clk or negedge rst_b) begin

		if (~rst_b) begin
			s <= 'b0;
			cout <= 'b0;
		end else begin
			s <= #(0.010) s_w;
			cout <= #(0.010) c[15];
		end
	end

endmodule
