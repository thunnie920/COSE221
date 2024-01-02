/* *******************************
 *	COSE221 Lab #2
 *
 *	Author: Gunjae Koo (gunjaekoo@korea.ac.kr)
 *
 * *******************************
 */

module test3(a, b, y, good);
   input         a, b, y;
   output         good;

   logic         good;

   always_comb begin
		case ({a, b})
			2'b00: good = y;
			2'b01: good = y;
			2'b10: good = y;
			default: good = ~y;
		endcase
	end
endmodule

