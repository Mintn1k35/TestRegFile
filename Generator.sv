// `include "ifDut.sv"
class GenData;
    rand bit [4:0] rd;
    bit [4:0] rs1, rs2;
    rand bit [31:0] data;
    bit reg_write;
    
    // Constructor
    function new();
    endfunction
endclass

class Generator;
    virtual ifDut ifDutPort;
    GenData data;
    // Constructor
    function new(virtual ifDut ifDutGen);
        ifDutPort = ifDutGen;
    endfunction

    task run(int max_value, int min_value, int number_regs);
        data = new();
        @(posedge ifDutPort.reset_n);
        for(int i = 0 ; i < 48; i = i + 1) begin
            @ (posedge ifDutPort.clk);
            if(i <= 31) begin
                data.rd = i;
                data.data = $urandom_range(max_value, min_value);
                ifDutPort.data = data.data;
                ifDutPort.rd = data.rd;
                data.reg_write = 1'b1;
                ifDutPort.reg_write = data.reg_write;
                // $display("time: %t, rd: %d, data: %d", $time,ifDutPort.rd, ifDutPort.data);
            end
            else begin
                data.reg_write = 1'b0;
                ifDutPort.reg_write = data.reg_write;
                data.rs1 = i - 16;
                data.rs2 = i;
                ifDutPort.rs1 = data.rs1;
                ifDutPort.rs2 = data.rs2;
                // $display("reg_write: %b", ifDutPort.reg_write);
            end
        end
        repeat (1) @(posedge ifDutPort.clk);
        $finish;
    endtask

endclass