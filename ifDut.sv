interface ifDut;
    logic clk, reset_n, reg_write;
    logic [4:0] rs1, rs2, rd;
    logic [31:0] data, rd1, rd2;
endinterface