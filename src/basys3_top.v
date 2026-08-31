module basys3_top #(
    parameter N_DATA = 8,
    parameter N_OP = 6
)(
    input wire clk,
    input wire [15:0] sw,
    input wire btnL,
    input wire btnR,
    input wire btnU,
    input wire btnD,
    output wire [15:0] led
);

reg [N_DATA-1:0] a_reg;
reg [N_DATA-1:0] b_reg;
reg [N_DATA-1:0] res_reg;

wire [N_DATA-1:0] res;

always @(posedge clk) begin
    if (btnL)
        a_reg <= sw[N_DATA-1:0];

    if (btnR)
        b_reg <= sw[N_DATA-1:0];

    if (btnU) begin
        res_reg <= res;
    end

    if (btnD) begin
        a_reg <= 0;
        b_reg <= 0;
        res_reg <= 0;
    end
end

alu #(
    .N_DATA(N_DATA),
    .N_OP(N_OP)
) alu_inst (
    .a(a_reg),
    .b(b_reg),
    .op(sw[N_OP-1:0]),
    .res(res)
);

assign led[N_DATA-1:0] = res_reg;
assign led[15:N_DATA] = 0;

endmodule