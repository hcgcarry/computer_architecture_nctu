 
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
wire [31:0] RDdata_i;
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
wire PCSrc_branch_select = Branch & zero;
wire [1:0] Jump;
wire MemRead,MemWrite,MemtoReg;
wire [31:0]PCsrc_branch_o;
wire [31:0]data_memory_o;
wire [31:0] Mux_memToReg_o;
		
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
        .RDdata_i(RDdata_i)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );
		
Decoder Decoder(
        .instr_i(instr), 
		.ALUSrc(ALUSrc),
	    .RegWrite(RegWrite),
	    .Branch(Branch),
		.ALUOp(ALUOp),      
		.Jump(Jump),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.MemtoReg(MemtoReg)
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
	
MUX_2to1 PCSrc_branch(
		.data0_i(PC_plus_4_o),       
		.data1_i(Branch_Adder_o),
		.select_i(PCSrc_branch_select),
		.data_o(PCsrc_branch_o)
		);
		
MUX_3to1 PCSrc_jump(
	.data0_i(PCsrc_branch_o),   //
	.data1_i(Branch_Adder_src2_i), // jal
	.data2_i(RSdata_o), //jalr
	.select_i(Jump),
	.data_o(pc_i)
);

Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(ALUresult),
	.data_i(RTdata_o),
	.MemRead_i(MemRead),
	.MemWrite_i(MemWrite),
	.data_o(data_memory_o)
);
MUX_2to1 Mux_memToReg(
	.data0_i(ALUresult),
	.data1_i(data_memory_o),
	.select_i(MemtoReg),
	.data_o(Mux_memToReg_o)
);
MUX_3to1 Mux_regWriteData(
	.data0_i(Mux_memToReg_o),
	.data1_i(PC_plus_4_o),
	.data2_i(0),
	.select_i(Jump),
	.data_o(RDdata_i)
);

endmodule
		  


