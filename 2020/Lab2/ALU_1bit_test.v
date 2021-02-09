
`timescale 1ns/100ps
module ALU_1bit_test;

reg src1,src2,Ainvert,Binvert,Cin;
reg [1:0] operation;
wire result ,cout;

ALU_1bit ALU_1bit_obj(
    .src1(src1),
    .src2(src2),
    .Ainvert(Ainvert),
    .Binvert(Binvert),
    .Cin(Cin),
    .operation(operation),
    .result(result),
    .cout(cout)
);


initial begin
    src1 = 0;
    src2 =0;
    Ainvert=0;
    Binvert=0;
    Cin =0;
    operation =0;
    #1;
    src1 = 1;
    src2 =1;
    Ainvert=0;
    Binvert=0;
    Cin =0;
    operation =2;
    #1
 src1 = 1;
    src2 =0;
    Ainvert=0;
    Binvert=0;
    Cin =0;
    operation =1;
    $display("result is %d",result);
end
endmodule