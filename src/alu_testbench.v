module alu_testbench;

localparam N_DATA = 8;
localparam N_OP = 6;

localparam ADD = 6'b100000;
localparam SUB = 6'b100010;
localparam AND = 6'b100100;
localparam OR  = 6'b100101;
localparam XOR = 6'b100110;
localparam SRA = 6'b000011;
localparam SRL = 6'b000010;
localparam NOR = 6'b100111;

reg [N_DATA-1:0] a_reg;
reg [N_DATA-1:0] b_reg;
reg [N_OP-1:0] op_reg;
wire [N_DATA-1:0] res;
wire zero;
wire overflow;
wire carry_out;

reg fails;

alu #(
    .N_DATA(N_DATA),
    .N_OP(N_OP)
) alu_inst (
    .a(a_reg),
    .b(b_reg),
    .op(op_reg),
    .res(res),
    .zero(zero),
    .overflow(overflow),
    .carry_out(carry_out)
);

initial begin
    fails = 1'b0;
    $display("Starting ALU Testbench...");

    $display("Testing ADD operation...");
    // Test ADD
    a_reg = 8'd10;
    b_reg = 8'd5;
    op_reg = ADD;
    #10;
    $display("ADD: %d + %d = %d (zero: %b, overflow: %b, carry: %b)", a_reg, b_reg, res, zero, overflow, carry_out);

    if (res !== 8'd15 || zero !== 1'b0 || overflow !== 1'b0 || carry_out !== 1'b0) begin
        $display("ADD test failed!");
        fails = 1;
    end else begin
        $display("ADD test passed.");
    end

    // Test ADD with overflow
    a_reg = 8'd127;
    b_reg = 8'd1;
    op_reg = ADD;
    #10;
    $display("ADD with overflow: %d + %d = %d (zero: %b, overflow: %b, carry: %b)", a_reg, b_reg, res, zero, overflow, carry_out);

    if (res !== 8'd128 || zero !== 1'b0 || overflow !== 1'b1 || carry_out !== 1'b0) begin
        $display("ADD with overflow test failed!");
        fails = 1;
    end else begin
        $display("ADD with overflow test passed.");
    end

    // Test ADD with carry
    a_reg = 8'd255;
    b_reg = 8'd1;
    op_reg = ADD;
    #10;
    $display("ADD with carry: %d + %d = %d (zero: %b, overflow: %b, carry: %b)", a_reg, b_reg, res, zero, overflow, carry_out);

    if (res !== 8'd0 || zero !== 1'b1 || overflow !== 1'b0 || carry_out !== 1'b1) begin
        $display("ADD with carry test failed!");
        fails = 1;
    end else begin
        $display("ADD with carry test passed.");
    end

    // Test ADD with zero result
    a_reg = 8'd0;   
    b_reg = 8'd0;
    op_reg = ADD;
    #10;
    $display("ADD with zero result: %d + %d = %d (zero: %b, overflow: %b, carry: %b)", a_reg, b_reg, res, zero, overflow, carry_out);

    if (res !== 8'd0 || zero !== 1'b1 || overflow !== 1'b0 || carry_out !== 1'b0) begin
        $display("ADD with zero result test failed!");
        fails = 1;
    end else begin
        $display("ADD with zero result test passed.");
    end

    // Test SUB
    a_reg = 8'd10;
    b_reg = 8'd5;
    op_reg = SUB;
    #10;
    $display("SUB: %d - %d = %d (zero: %b, overflow: %b, carry: %b)", a_reg, b_reg, res, zero, overflow, carry_out);

    if (res !== 8'd5 || zero !== 1'b0 || overflow !== 1'b0 || carry_out !== 1'b0) begin
        $display("SUB test failed!");
        fails = 1;
    end else begin
        $display("SUB test passed.");
    end

    // Test SUB with borrow
    a_reg = 8'd0;
    b_reg = 8'd1;
    op_reg = SUB;
    #10;
    $display("SUB with borrow: %d - %d = %d (zero: %b, overflow: %b, carry: %b)", a_reg, b_reg, res, zero, overflow, carry_out);

    if (res !== 8'd255 || zero !== 1'b0 || overflow !== 1'b0 || carry_out !== 1'b1) begin
        $display("SUB with borrow test failed!");
        fails = 1;
    end else begin
        $display("SUB with borrow test passed.");
    end

    // Test SUB with zero result
    a_reg = 8'd5;
    b_reg = 8'd5;
    op_reg = SUB;
    #10;
    $display("SUB with zero result: %d - %d = %d (zero: %b, overflow: %b, carry: %b)", a_reg, b_reg, res, zero, overflow, carry_out);

    if (res !== 8'd0 || zero !== 1'b1 || overflow !== 1'b0 || carry_out !== 1'b0) begin
        $display("SUB with zero result test failed!");
        fails = 1;
    end else begin
        $display("SUB with zero result test passed.");
    end

    // Test SUB with carry
    a_reg = 8'd5;
    b_reg = 8'd10;
    op_reg = SUB;
    #10;
    $display("SUB with carry: %d - %d = %d (zero: %b, overflow: %b, carry: %b)", a_reg, b_reg, res, zero, overflow, carry_out);

    if (res !== 8'd251 || zero !== 1'b0 || overflow !== 1'b0 || carry_out !== 1'b1) begin
        $display("SUB with carry test failed!");
        fails = 1;
    end else begin
        $display("SUB with carry test passed.");
    end

    // Test AND
    a_reg = 8'b11001100;
    b_reg = 8'b10101010;
    op_reg = AND;
    #10;
    $display("AND: %b & %b = %b", a_reg, b_reg, res);

    if (res !== 8'b10001000 || zero !== 1'b0 || overflow !== 1'b0 || carry_out !== 1'b0) begin
        $display("AND test failed!");
        fails = 1;
    end else begin
        $display("AND test passed.");
    end

    // Test OR
    a_reg = 8'b11001100;
    b_reg = 8'b10101010;
    op_reg = OR;
    #10;
    $display("OR: %b | %b = %b", a_reg, b_reg, res);

    if (res !== 8'b11101110 || zero !== 1'b0 || overflow !== 1'b0 || carry_out !== 1'b0) begin
        $display("OR test failed!");
        fails = 1;
    end else begin
        $display("OR test passed.");
    end

    // Test XOR
    a_reg = 8'b11001100;
    b_reg = 8'b10101010;
    op_reg = XOR;
    #10;
    $display("XOR: %b ^ %b = %b", a_reg, b_reg, res);

    if (res !== 8'b01100110 || zero !== 1'b0 || overflow !== 1'b0 || carry_out !== 1'b0) begin
        $display("XOR test failed!");
        fails = 1;
    end else begin
        $display("XOR test passed.");
    end

    // Test SRA
    a_reg = 8'b11001100;
    b_reg = 8'd2;
    op_reg = SRA;
    #10;
    $display("SRA: %b >>> %d = %b", a_reg, b_reg, res);

    if (res !== 8'b11110011 || zero !== 1'b0 || overflow !== 1'b0 || carry_out !== 1'b0) begin
        $display("SRA test failed!");
        fails = 1;
    end else begin
        $display("SRA test passed.");
    end

    // Test SRL
    a_reg = 8'b11001100;
    b_reg = 8'd2;
    op_reg = SRL;
    #10;
    $display("SRL: %b >> %d = %b", a_reg, b_reg, res);

    if (res !== 8'b00110011 || zero !== 1'b0 || overflow !== 1'b0 || carry_out !== 1'b0) begin
        $display("SRL test failed!");
        fails = 1;
    end else begin
        $display("SRL test passed.");
    end

    // Test NOR
    a_reg = 8'b11001100;
    b_reg = 8'b10101010;
    op_reg = NOR;
    #10;
    $display("NOR: ~(%b | %b) = %b", a_reg, b_reg, res);

    if (res !== 8'b00010001 || zero !== 1'b0 || overflow !== 1'b0 || carry_out !== 1'b0) begin
        $display("NOR test failed!");
        fails = 1;
    end else begin
        $display("NOR test passed.");
    end

    if (fails) begin
        $display("ALU Testbench completed with failures.");
    end else begin
        $display("ALU Testbench completed successfully.");
    end
end

endmodule
