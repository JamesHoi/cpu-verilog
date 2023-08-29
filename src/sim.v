

module sim;

//clock
parameter CLK_PERIOD = 40; 
reg sys_clk;
initial
    sys_clk = 1'b0;
always
    sys_clk = #(CLK_PERIOD/2) ~sys_clk;

reg sys_rst_n;  //active low
initial 
begin
  sys_rst_n = 1'b0;
  #200;
  sys_rst_n = 1'b1;
end

reg [1:0] sel;
reg [3:0] reg_sel;
initial
begin
  sel = 2'b11;
  reg_sel = 4'b1110;
end

reg [607:0] rom;
initial
begin
	rom = 576'h40FC000281707F000001A6500F0FA5000F0FA4000F0FA3000005A2000005A10060226142613162000001816000018150000181400001813080008120000881100002810001FF81F0;
end

wire c,z,v,s,wr;
wire[15:0] address_bus,reg_data;

wire [15:0] data_bus;
assign data_bus = rom[(address_bus+1)*16-1-:16];

cpu0 c1(
   .reset(sys_rst_n),
   .clk(sys_clk),
   .wr(wr),
   .c(c), .z(z), .v(v), .s(s),
   .sel(sel),
   .reg_sel(reg_sel),
   .data_bus(data_bus),
   .address_bus(address_bus),
   .reg_data(reg_data)
);

endmodule