//Verilog testbench template generated by SCUBA Diamond_1.2_Production (92)
`timescale 1 ns / 1 ps
module tb;
    reg [11:0] DataA = 12'b0;
    reg [11:0] DataB = 12'b0;
    reg Add_Sub = 0;
    wire [11:0] Result;

    integer i0 = 0, i1 = 0, i2 = 0, i3 = 0;

    GSR GSR_INST (.GSR(1'b1));
    PUR PUR_INST (.PUR(1'b1));

    add_sub u1 (.DataA(DataA), .DataB(DataB), .Add_Sub(Add_Sub), .Result(Result)
    );

    initial
    begin
       DataA <= 0;
      for (i1 = 0; i1 < 200; i1 = i1 + 1) begin
        #10;
         DataA <= DataA + 1'b1;
      end
    end
    initial
    begin
       DataB <= 0;
      for (i2 = 0; i2 < 200; i2 = i2 + 1) begin
        #10;
         DataB <= DataB + 1'b1;
      end
    end
    initial
    begin
       Add_Sub <= 1'b1;
      for (i3 = 0; i3 < 100; i3 = i3 + 1) begin
        #10;
      end
       Add_Sub <= 1'b0;
    end
endmodule