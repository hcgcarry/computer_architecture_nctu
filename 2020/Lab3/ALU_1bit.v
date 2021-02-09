/***************************************************
Student Name: 
Student ID: 
***************************************************/
`timescale 1ns/1ps

module ALU_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				Cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	output reg          result,     //1 bit result    (output)
	output reg          cout        //1 bit carry out (output)
	);

/* Write your code HERE */

	wire tmp_a,tmp_b,aAndb,aOrb;
	wire [1:0] aAddb;
	assign tmp_a = Ainvert?(~src1):(src1);
	assign tmp_b = Binvert?(~src2):(src2);
	assign aAndb = tmp_a & tmp_b;
	assign aOrb = tmp_a | tmp_b;
	assign 	aAddb = tmp_a + tmp_b + Cin;
	
	always@(*)begin
		
		
		//$display("in first loop");
//$display("The current time is %0t", $time);


		//$display("src1 %d ,src2 %d ,Ainvert %d ,Binvert %d ,Cin %d ,operation %d,result %d,cout %d",src1,src2,Ainvert,Binvert,Cin,operation,result,cout);
	end
	always@(*)begin
	//$display("in second loop");
		//$display("The current time is %0t", $time);
//$display("src1 %d ,src2 %d ,Ainvert %d ,Binvert %d ,Cin %d ,operation %d,result %d,cout %d",src1,src2,Ainvert,Binvert,Cin,operation,result,cout);	
		case(operation)
			2'b00:
				result <= aAndb;
			2'b01:
				result <= aOrb;
			2'b10:begin
				cout <= aAddb / 2;	
				result <= aAddb%2;
			end
			2'b11:begin
				cout <= aAddb / 2;	
				result <= aAddb%2;
			end
		endcase

	end
			
		

endmodule
