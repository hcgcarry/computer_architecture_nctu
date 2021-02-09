
module instr_type_decoder(
	input [32-1:0] 	instr_i,
    output [2:0] instr_type_o
);
wire	[3-1:0]		Instr_field;
wire	[6:0]		opcode;
wire [2:0] funct3;

assign opcode = instr_i[6:0];
assign funct3 = instr_i[14:12];

// Check Instr. Field
// 0:R-type, 1:I-type, 2:S-type, 3:B-type	4:J-type				 
assign instr_type_o = (opcode==7'b1101111)?4:( // JAL
					(opcode==7'b1100011)?3:(
                     (opcode==7'b0100011)?2:(( //SW
					 (opcode==7'b0000011 && funct3==3'b010) ||	//LW
					 (opcode==7'b1100111 && funct3==3'b000) ||	//JALR
                     (opcode==7'b0010011 && funct3==3'b000) ||	//ADDI
					 (opcode==7'b0010011 && funct3==3'b010) ||	//SLTI
					 (opcode==7'b0010011 && funct3==3'b100) ||	//XORI
					 (opcode==7'b0010011 && funct3==3'b110) ||	//ORI
					 (opcode==7'b0010011 && funct3==3'b111))?1:(//ANDI
					 (opcode==7'b0110011)?0:
					 1))));
				endmodule