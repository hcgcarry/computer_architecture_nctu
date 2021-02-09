module ForwardingUnit (instr_i,EXE_instr19_15, EXE_instr24_20, MEM_instr11_7, MEM_WBControl, WB_instr11_7, WB_Control, src1_sel_o, src2_sel_o);

	input [31:0]instr_i;
	input [5-1:0] EXE_instr19_15, EXE_instr24_20, MEM_instr11_7, WB_instr11_7;
	input [2-1:0] MEM_WBControl, WB_Control;
	output wire [2-1:0] src1_sel_o, src2_sel_o;
	wire [2:0] instr_type ;
	instr_type_decoder instr_type_decoder_obj(
		.instr_i(instr_i),
		.instr_type_o(instr_type)
	);

	
	assign src1_sel_o =	(MEM_WBControl[1]==1 && (MEM_instr11_7 == EXE_instr19_15))?2'd2:
						(WB_Control[1]==1 && (WB_instr11_7 == EXE_instr19_15))?2'd1:
						2'd0;
	
	assign src2_sel_o =	(instr_type != 1 )?(
							(MEM_WBControl[1]==1 && (MEM_instr11_7 == EXE_instr24_20))?2'd2:
							(WB_Control[1]==1 &&(WB_instr11_7 == EXE_instr24_20))?2'd1:
							2'd0
						):0;

endmodule
 