class Monitor;
    virtual ifDut ifDutPort;

    bit [31:0] mem[0:31];

    function new(virtual ifDut ifDutMon);
        ifDutPort = ifDutMon;
    endfunction

    task run();
        while(1) begin
            #6
            @(posedge ifDutPort.clk);
            #2
            if(ifDutPort.reset_n) begin
                if(ifDutPort.reg_write == 1'b1) begin
                    mem[ifDutPort.rd] = ifDutPort.data;
                    // $display("time: %t, mem[%d] = %d", $time,ifDutPort.rd, ifDutPort.data);
                end
                else begin
                    if(mem[ifDutPort.rs1] == ifDutPort.rd1) $display("time: %t, Pass rd%d", $time,ifDutPort.rs1);
                    else $display("time: %t, Not pass rd%d", $time,ifDutPort.rs1);
                    if(mem[ifDutPort.rs2] == ifDutPort.rd2) $display("time: %t, Pass rd%d", $time, ifDutPort.rs2);
                    else $display("time: %t, Not pass rd%d", $time, ifDutPort.rs2);
                    // $display("mem[%d]: %d vs rd1: ", ifDutPort.rs1, mem[ifDutPort.rs1], ifDutPort.rd1);
                end
            end
        end
    endtask
endclass