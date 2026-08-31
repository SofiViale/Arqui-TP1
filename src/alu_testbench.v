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

alu #(
    .N_DATA(N_DATA),
    .N_OP(N_OP)
) alu_inst (
    .a(a_reg),
    .b(b_reg),
    .op(op_reg),
    .res(res)
);

initial begin
    // Test ADD
    $display("Starting ALU Testbench...");
    $display("Testing ADD operation...");

    // Test simple
    a_reg = 8'd10;
    b_reg = 8'd5;
    op_reg = ADD;
    #10;
    $display("ADD: %d + %d = %d", a_reg, b_reg, res);


    // Test SUB
    a_reg = 8'd10;
    b_reg = 8'd5;
    op_reg = SUB;
    #10;
    $display("SUB: %d - %d = %d", a_reg, b_reg, res);

    // Test AND
    a_reg = 8'b11001100;
    b_reg = 8'b10101010;
    op_reg = AND;
    #10;
    $display("AND: %b & %b = %b", a_reg, b_reg, res);

    // Test OR
    a_reg = 8'b11001100;
    b_reg = 8'b10101010;
    op_reg = OR;
    #10;
    $display("OR: %b | %b = %b", a_reg, b_reg, res);

    // Test XOR
    a_reg = 8'b11001100;
    b_reg = 8'b10101010;
    op_reg = XOR;
    #10;
    $display("XOR: %b ^ %b = %b", a_reg, b_reg, res);

    // Test SRA
    a_reg = 8'b11001100;
    b_reg = 8'd2;
    op_reg = SRA;
    #10;
    $display("SRA: %b >>> %d = %b", a_reg, b_reg, res);

    // Test SRL
    a_reg = 8'b11001100;
    b_reg = 8'd2;
    op_reg = SRL;
    #10;
    $display("SRL: %b >> %d = %b", a_reg, b_reg, res);

    // Test NOR
    a_reg = 8'b11001100;
    b_reg = 8'b10101010;
    op_reg = NOR;
    #10;
    $display("NOR: ~(%b | %b) = %b", a_reg, b_reg, res);
end

endmodule