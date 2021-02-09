/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Imm_Gen(
	input  [31:0] instr_i,
	output [31:0] Imm_Gen_o
	);

/* Write your code HERE */
// 如果要增加instruction type 要確定instr_field 的bit數可以裝得下
reg ALU_Ctrl_o;
wire [2:0] instr_field;
wire [6:0] opcode;
wire [2:0] funct3;
assign opcode = instr_i[6:0];
assign funct3 = instr_i[14:12];
// 0:R-type, 1:I-type, 2:S-type, 3:B-type	,4:j-type				 
assign instr_field = (opcode==7'b1101111)?4:(
					(opcode==7'b1100011)?3:(
                     (opcode==7'b0100011)?2:((
					 (opcode==7'b0000011 && funct3==3'b010) ||	//LW
					 (opcode==7'b1100111 && funct3==3'b000) ||	//JALR
                     (opcode==7'b0010011 && funct3==3'b000) ||	//ADDI
					 (opcode==7'b0010011 && funct3==3'b001) ||	//SLLI
					 (opcode==7'b0010011 && funct3==3'b010) ||	//SLTI
					 (opcode==7'b0010011 && funct3==3'b100) ||	//XORI
					 (opcode==7'b0010011 && funct3==3'b101) ||	//SRLI
					 (opcode==7'b0010011 && funct3==3'b110) ||	//ORI
					 (opcode==7'b0010011 && funct3==3'b111))?1:(//ANDI
					 (opcode==7'b0110011)?0:
					 1))));
					 
assign Imm_Gen_o = (instr_field == 1)?$signed(instr_i[31:20]):(
					(instr_field == 2)?$signed({instr_i[31:25],instr_i[11:7]}):(
					(instr_field == 3)?$signed({instr_i[31],instr_i[7],instr_i[30:25],instr_i[11:8]}) :(
					(instr_field == 4)?$signed({instr_i[31],instr_i[19:12],instr_i[20],instr_i[30:21]}) :(
					0))));



				
endmodule