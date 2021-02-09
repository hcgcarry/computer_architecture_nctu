/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module MSB_ALU(
	input				a, 
	input				b,
	input 				Less,
	input 				Ainvert,
	input				Binvert,
	input 				Cin,
	input 		[3-1:0] Operation,
	output wire 		Result,
	output wire 		Set,
	output wire 		Overflow,
	output wire 		Cout
	);

wire in1,in2;
wire op0,op1,op2;

assign in1 = Ainvert?~a:a;
assign in2 = Binvert?~b:b;
and a1(op0,in1,in2);
or  o1(op1,in1,in2);
Full_adder FA(in1,in2,Cin,Cout,op2);

assign Result = (Operation==0)?op0:(
				(Operation==1)?op1:(
				(Operation==2)?op2:
				Less));

assign Set = op2;
//assign Overflow = Cout;
assign Overflow = (a&b&Binvert&Cout)?1:(Cout==1&&Operation==2&&Binvert==0)?1:0;
				
endmodule