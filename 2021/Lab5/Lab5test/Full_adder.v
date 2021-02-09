/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Full_adder(
	input		Ain, 
	input		Bin,
	input 		Cin,
	output wire Cout,
	output wire Sum
	);

	wire w1, w2, w3;

	xor x1(w1, Ain, Bin);
	xor x2(Sum, w1, Cin);
	and a1(w2, Ain, Bin);
	and a2(w3, w1, Cin);
	or o1(Cout, w2, w3);

endmodule