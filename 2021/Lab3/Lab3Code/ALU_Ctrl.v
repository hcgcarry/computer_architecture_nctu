/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input	[4-1:0]	instr,
	input	[2-1:0]	ALUOp,
	output	reg [4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */
//note you can't not change the order of the below else if 

wire [2:0]funct3;
assign funct3 = instr[2:0];
always@(*)begin
	if(ALUOp == 0) ALU_Ctrl_o = 4'b0010;
	else if(ALUOp == 2'b11 && funct3 == 3'b010) ALU_Ctrl_o = 4'b0111;//SLTI
	else if(ALUOp == 2'b10 && instr == 4'b0010) ALU_Ctrl_o = 4'b0111;//SLT
	else if(ALUOp == 2'b10 && instr == 4'b0100) ALU_Ctrl_o = 4'b1000;//XOR
	else if(ALUOp == 2'b10 && instr == 4'b0001) ALU_Ctrl_o = 4'b1001;//sll 
	else if(ALUOp == 2'b11 && instr== 4'b0001) ALU_Ctrl_o = 4'b1010;//slli
	else if(ALUOp == 2'b10 && instr == 4'b1101) ALU_Ctrl_o = 4'b1011;//sra
	else if(ALUOp == 2'b11 && instr == 4'b0101) ALU_Ctrl_o = 4'b1100;//srli
	else if(ALUOp[1] == 1 && instr == 0) ALU_Ctrl_o = 4'b0010;
	else if(ALUOp[1] == 1 && instr[3] == 1 && instr[2:0] == 0) ALU_Ctrl_o = 4'b0110;
	else if(ALUOp[1] == 1 && instr[3] == 0 && instr[2:0] == 7) ALU_Ctrl_o = 4'b0000;
	else if(ALUOp[1] == 1 && instr[3] == 0 && instr[2:0] == 6) ALU_Ctrl_o = 4'b0001;
	else if(ALUOp == 1) ALU_Ctrl_o = 4'b0110;
end


endmodule