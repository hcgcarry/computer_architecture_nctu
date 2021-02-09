/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);

//Internal Signles
wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] instr;
wire [31:0] ALUresult;
wire RegWrite;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire ALUSrc;
wire Branch;
wire [1:0] ALUOp;
wire [31:0]PC_plus_4_o;
wire [31:0]Imm_Gen_o;
wire [31:0]Branch_Adder_src2_i;
wire [31:0]Branch_Adder_o;
wire [3:0]ALU_control;
wire [31:0]ALU_src2_i;
wire zero,cout,overflow;
wire [31:0]imm_4 = 4;
wire [6:0]opcode;
wire [2:0]funct3;
assign opcode = instr[6:0];
assign funct3 = instr[14:12];
wire PCSrc =(opcode == 7'b1100011 && funct3 == 3'b001)?Branch&(~zero) : Branch & zero;
		
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_i(pc_i) ,   
	    .pc_o(pc_o) 
	    );

Instr_Memory IM(
        .addr_i(pc_o),  
	    .instr_o(instr)    
	    );
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr[19:15]) ,  
        .RTaddr_i(instr[24:20]) ,  
        .RDaddr_i(instr[11:7]) ,  
        .RDdata_i(ALUresult)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );
		
Decoder Decoder(
        .instr_i(instr), 
		.ALUSrc(ALUSrc),
	    .RegWrite(RegWrite),
	    .Branch(Branch),
		.ALUOp(ALUOp)      
	    );	

Adder PC_plus_4_Adder(
        .src1_i(pc_o),     
	    .src2_i(imm_4),     
	    .sum_o(PC_plus_4_o)    
	    );
		
Imm_Gen ImmGen(
		.instr_i(instr),
		.Imm_Gen_o(Imm_Gen_o)
		);
	
Shift_Left_1 SL1(
		.data_i(Imm_Gen_o),
		.data_o(Branch_Adder_src2_i)
		);
	
MUX_2to1 Mux_ALUSrc(
		.data0_i(RTdata_o),       
		.data1_i(Imm_Gen_o),
		.select_i(ALUSrc),
		.data_o(ALU_src2_i)
		);
			
ALU_Ctrl ALU_Ctrl(
		.instr({instr[30],instr[14:12]}),
		.ALUOp(ALUOp),
		.ALU_Ctrl_o(ALU_control)
		);
		
Adder Branch_Adder(
        .src1_i(pc_o),     
	    .src2_i(Branch_Adder_src2_i),     
	    .sum_o(Branch_Adder_o)    
	    );
		
alu alu(
		.rst_n(rst_i),
		.src1(RSdata_o),
		.src2(ALU_src2_i),
		.ALU_control(ALU_control),
		.zero(zero),
		.result(ALUresult),
		.cout(cout),
		.overflow(overflow)
		);
	
MUX_2to1 Mux_PCSrc(
		.data0_i(PC_plus_4_o),       
		.data1_i(Branch_Adder_o),
		.select_i(PCSrc),
		.data_o(pc_i)
		);
		
endmodule
		  


