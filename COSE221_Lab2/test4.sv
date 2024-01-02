/* *******************************
 *	COSE221 Lab #2
 *
 *	Author: Gunjae Koo (gunjaekoo@korea.ac.kr)
 *
 * *******************************
 */

module tristate(a, en, y);
	input			a, en;
	output	tri		y;

	assign y = (en) ? a: 1'bZ;
endmodule

module mux2(a, b, sel, y);
	input			a, b, sel;
	output	tri		y;

	tristate tristate_0 (a, ~sel, y);
	tristate tristate_1 (b, sel, y);
endmodule

module test4(a, b, y, good);
	input			a, b, y;
	output	tri		good;

	tri yMux;
	tri bMux1;
	tri bMux2;

	mux2 yMux_2 (1'b1, 1'b0, y, yMux);
	mux2 b1Mux_2 (y, y, b, bMux1);
	mux2 b2Mux2_2 (y, yMux, b, bMux2);
	mux2 aMux_2 (bMux1, bMux2, a, good);

endmodule
