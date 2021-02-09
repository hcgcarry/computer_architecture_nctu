module Hazard_detection(
input [4:0] IFID_regRs,
input [4:0] IFID_regRt,
input [4:0] IDEXE_regRd,
input IDEXE_memRead,
output PC_write,
output IFID_write,
output control_output_select
);

wire lw_dataHazard_detection;
assign lw_dataHazard_detection = (IDEXE_memRead && ((IDEXE_regRd == IFID_regRs) || (IDEXE_regRd == IFID_regRt)))?1:0;
//assign lw_dataHazard_detection = 0;

assign PC_write = ~lw_dataHazard_detection;
assign IFID_write = ~lw_dataHazard_detection;
assign control_output_select= lw_dataHazard_detection;

endmodule

