`timescale  1ns/1ps
`include "RegFile.v"
`include "Generator.sv"
`include "ifDut.sv"
`include "Monitor.sv"
module tb;
    logic clk, reset_n;
    logic [4:0] rd, rs1, rs2;
    logic [31:0] data, rd1, rd2;
    logic reg_write;
    ifDut driver();
    Generator gen;
    Monitor mon;
    parameter CLOCK = 20;

    always #(CLOCK/2) clk = ~clk;

    initial begin
        clk = 1'b0;
        reset_n = 1'b0;
        #(CLOCK * 2) 
        reset_n = 1'b1;
    end
    
    assign driver.clk = clk;
    assign driver.reset_n = reset_n;

    RegFile regfile(driver.clk, driver.reset_n, driver.reg_write, driver.data, driver.rd, driver.rs1, driver.rs2, driver.rd1, driver.rd2);

    initial begin
        gen = new(driver);
        mon = new(driver);
        fork
            gen.run(31, 0, 32);
            mon.run();
        join
       

        #2000
        $stop;
    end

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
    end
    assign rd = driver.rd;
    assign rs1 = driver.rs1;
    assign rs2 = driver.rs2;
    assign reg_write = driver.reg_write;
    assign rd1 = driver.rd1;
    assign rd2 = driver.rd2;
    assign data = driver.data;
    
endmodule