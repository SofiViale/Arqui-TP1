module alu #(
    parameter N_DATA = 8,
    parameter N_OP = 6
)(
    input wire [N_DATA-1:0] a,
    input wire [N_DATA-1:0] b,
    input wire [N_OP-1:0] op,
    output wire [N_DATA-1:0] res
);

localparam ADD = 6'b100000;
localparam SUB = 6'b100010;
localparam AND = 6'b100100;
localparam OR  = 6'b100101;
localparam XOR = 6'b100110;
localparam SRA = 6'b000011;
localparam SRL = 6'b000010;
localparam NOR = 6'b100111;

reg [N_DATA-1:0] result;

always @(*) begin
    case(op)
        ADD: result = a + b;
        SUB: result = a - b;
        AND: result = a & b;
        OR:  result = a | b;
        XOR: result = a ^ b;
        SRA: result = $signed(a) >>> b;
        SRL: result = a >> b;
        NOR: result = ~(a | b);
        default: result = {N_DATA{1'b0}};
    endcase
end

assign res = result;

endmodule