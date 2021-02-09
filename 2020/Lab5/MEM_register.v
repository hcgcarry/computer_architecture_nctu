module MEM_register (clk_i, rst_i, instr_i, WB_i, Mem_i, addsum_i, zero_i, alu_ans_i, rtdata_i, WBreg_i, instr_o, WB_o, Mem_o, addsum_o, zero_o, alu_ans_o, rtdata_o, WBreg_o);

	input clk_i;
	input rst_i;
	input [31:0] instr_i;
	input [1:0] WB_i;
	input [2:0] Mem_i;
	input [31:0] addsum_i;
	input zero_i;
	input [31:0] alu_ans_i;
	input [31:0] rtdata_i;
	input [4:0] WBreg_i;
	
	output reg [31:0] instr_o;
	output reg [1:0] WB_o;
	output reg [2:0] Mem_o;
	output reg [31:0] addsum_o;
	output reg zero_o;
	output reg [31:0] alu_ans_o;
	output reg [31:0] rtdata_o;
	output reg [4:0] WBreg_o;

	always@(posedge clk_i)
	begin
		if (!rst_i)
		begin
			instr_o <= 0;
			WB_o <= 0;
			Mem_o <= 0;
			addsum_o <= 0;
			zero_o <= 0;
			alu_ans_o <= 0;
			rtdata_o <= 0;
			WBreg_o <= 0;
		end
		else
		begin
			instr_o <= instr_i;
			WB_o <= WB_i;
			Mem_o <= Mem_i;
			addsum_o <= addsum_i;
			zero_o <= zero_i;
			alu_ans_o <= alu_ans_i;
			rtdata_o <= rtdata_i;
			WBreg_o <= WBreg_i;
		end
	end

endmodule
