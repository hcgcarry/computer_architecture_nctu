/***************************************************
Student Name:
Student ID:
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	signed    [32-1:0]	src1,          // 32 bits source 1          (input)
	input	signed     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */

wire Cin[31:0] ,Cout_1bit_list[31:0];
wire [1:0]operation;
wire Ainvert,Binvert;
assign Ainvert = ALU_control[3];
assign Binvert = ALU_control[2];
assign operation = ALU_control[1:0];
assign Cin[0] = Binvert;
genvar i ;
wire [31:0]Wire_result;

always@(*)begin
	if(!rst_n)begin
		result=0;
		zero=0;
		cout=0;
		overflow=0;
	end
end

// result
// note we need to let comparation which has more bit higher
always@(*)begin
	if (ALU_control== 4'b1000)begin
		result = src1 ^ src2;
	end
	else if (ALU_control== 4'b1001 || ALU_control == 4'b1010)begin
		result = src1 << src2;
	end
	else if (ALU_control== 4'b1011)begin
		result = src1 >>> src2;
	end
	else if (ALU_control== 4'b1100)begin
		result = src1 >> src2;
	end
	else if(operation == 3)begin
		result  = Wire_result[31] ? 1:0;
	end
	else begin
		result = Wire_result;
	end
	if(result ==0 ) zero =1;
	else zero=0;
end


always@(*)begin
	cout = Cout_1bit_list[31];
end
always@(*)begin
	overflow = Cout_1bit_list[30] ^ Cout_1bit_list[31];
end

generate
	for(i=1;i<32;i=i+1)begin
		assign Cin[i] = Cout_1bit_list[i-1];
	end
endgenerate
	

generate
	for(i=0;i<32;i=i+1)begin
	ALU_1bit ALU_1bin_obj(
		.src1(src1[i]),
		.src2(src2[i]),
		.Ainvert(Ainvert), 
		.Binvert(Binvert), 
		.Cin(Cin[i]),    
		.operation(operation),
		.result(Wire_result[i]),  
		.cout(Cout_1bit_list[i])   
		);
	end


endgenerate

endmodule
