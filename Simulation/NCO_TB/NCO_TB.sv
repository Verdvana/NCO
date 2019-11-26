//------------------------------------------------------------------------------
//
//Module Name:					NCO_TB.v
//Department:					Xidian University
//Function Description:	   数字控制振荡器测试文件
//
//------------------------------------------------------------------------------
//
//Version 	Design		Coding		Simulata	  Review		Rel data
//V1.0		Verdvana		Verdvana		Verdvana		  			2019-11-26
//
//-----------------------------------------------------------------------------------
//
//Version	Modified History
//V1.0		50MHz时钟
//				第一阶段：频率控制字为20000，即20kHz；
//							相位控制字为0。
//				第二阶段：频率控制字为250000，即250kHz；
//							相位控制字为0。
//				第三阶段：频率控制字不变；
//							相位控制字为25，即4/pi。
//				第四阶段：频率控制字为5000000，即5MHz；
//							相位控制字不变。	
//
//-----------------------------------------------------------------------------------

`timescale 1ns/1ns

module NCO_TB;

	reg clk;					
	reg rst_n;
	
	reg en;
	
	reg [23:0] 	fre_chtr;
	reg [6:0]	pha_chtr;
	
	wire [15:0] sin_out;
	wire [15:0] cos_out;



	NCO #(
			.CLK_FREQUENCY(50000000),			//时钟频率（Hz）	
			.DATA_WIDTH(16) 				//输出数据位宽
	)u_NCO(
			.clk(clk),		//50M时钟
			.rst_n(rst_n),
			
			.en(en),
			.fre_chtr(fre_chtr),
			.pha_chtr(pha_chtr),
			
			.sin_out(sin_out),
			.cos_out(cos_out)
	);  
	
	initial begin
		
		clk <= 0;
		forever #10 clk <= ~clk;
		
	end
	
	task task_rst; 
	begin	
		
		rst_n <= 0;
		repeat(2)@(posedge clk);
		rst_n <= 1;
		
	end
	endtask
	
	task task_sysinit; 
	begin
		
		fre_chtr <= 24'd20000;
		pha_chtr <= 7'd0;
		en  		<= 1'b0;
		
	end
	endtask
	
	initial begin
	
		task_sysinit;
		task_rst;
		
		#100;
		
		en <=1;
		
		
		
		#100000;
		
		fre_chtr <= 250000;
		
		#10000;
		
		en<=0;
		
		#100;
		
		pha_chtr <= 7'd25;
		
		#100;
		
		en<=1;
		
		#10000;
		
		fre_chtr <= 5000000;
		
		#10000;
	
		$stop;
	
	end

endmodule
	
	
		
			
		
	