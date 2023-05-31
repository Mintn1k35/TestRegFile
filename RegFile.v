module RegFile(
    input wire clk, reset_n, reg_write,
    input wire [31:0] data,
    input wire [4:0] rd, rs1, rs2,
    output wire [31:0] rd1, rd2
);
    
    reg [31:0] regs[31:0];
    integer i;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n) begin
            for(i = 0 ; i < 32 ; i = i + 1) begin
                regs[i] <= 32'd0;
            end
        end
        else begin
            if(reg_write) regs[rd] <= data;
        end
    end
    
    assign rd1 = regs[rs1];
    assign rd2 = regs[rs2];
endmodule