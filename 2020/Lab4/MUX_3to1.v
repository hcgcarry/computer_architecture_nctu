/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module MUX_3to1(
	input  [31:0] data0_i,       
	input  [31:0] data1_i,
	input  [31:0] data2_i,
	input  [ 1:0] select_i,
	output [31:0] data_o
    );		   

/* Write your code HERE */
assign data_o = (select_i == 2'b00)?data0_i:(
				(select_i == 2'b01)?data1_i:(
				(select_i == 2'b10)?data2_i:0
				));


endmodule      
          