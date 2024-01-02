/* *******************************
 *	COSE221 Lab #2
 *
 *	Author: Gunjae Koo (gunjaekoo@korea.ac.kr)
 *
 * *******************************
 */

module test2(a, b, y, good);
	input			a, b, y;
	output			good;

	assign yMux = y ? 0 : 1;
	assign bMux1 = b ? y : y;
	assign bMux2 = b ? yMux : y;
	
	assign good = a ? bMux2 : bMux1;

endmodule
