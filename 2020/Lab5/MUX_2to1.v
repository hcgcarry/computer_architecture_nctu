/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module MUX_2to1(
	input   	[32-1:0] data0_i,       
	input   	[32-1:0] data1_i,
	input       	     select_i,
	output wire [32-1:0] data_o
               );			   

assign data_o = (select_i==0)?data0_i:
				(select_i==1)?data1_i:
				0;

endmodule      
          