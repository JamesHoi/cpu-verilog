
module cpu0(
   input         reset,
   input         clk,
   output 		  wr,
   output c, z, v, s,
   input [1:0]   sel,
   input [3:0]   reg_sel,
   inout [15:0]  data_bus,
   output [15:0] address_bus,
   output [15:0] reg_data
);
   
   wire fc, fz, fv, fs;
   wire en_pc, en_reg_mux, alu_cin;
   wire [15:0] en_reg;
   wire [1:0]    sst;
   wire [1:0]    sci;
   wire [1:0]    rec;
   wire [2:0]    tim;
   wire [2:0]    alu_func;
	wire 			  alu_func2;
   wire [2:0]    alu_in_sel;
   wire [3:0]    d_reg;
   wire [3:0]    s_reg;
   wire [7:0]    offset_8;
   wire [15:0]   instruction;
   wire [15:0]   alu_sr;
   wire [15:0]   alu_dr;
   wire [15:0]   alu_out;
   wire [15:0]   reg_test;
   wire [15:0]   offset_16;
   wire [15:0]   ar_bus;
   wire [15:0]   pc_bus;
   wire [255:0]   reg_group;
   wire [15:0]   reg_inout;
   wire [15:0]   sr;
   wire [15:0]   dr;
	wire [3:0] 	  imm;
   
   controller f1(.timer(tim), 
                 .instruction(instruction), 
                 .c(c), .z(z), .v(v), .s(s), 
                 .dest_reg(d_reg), 
                 .sour_reg(s_reg), 
                 .offset(offset_8), 
                 .sst(sst), .sci(sci), .rec(rec), 
                 .alu_func(alu_func), .alu_func2(alu_func2),
                 .alu_in_sel(alu_in_sel), 
                 .en_reg(en_reg_mux), 
                 .en_pc(en_pc), 
                 .wr(wr),.imm(imm));
   
   alu f2(.cin(alu_cin), 
          .alu_a(alu_sr), 
          .alu_b(alu_dr), 
          .alu_func(alu_func),.alu_func2(alu_func2), 
          .alu_out(alu_out), 
          .c(fc), .z(fz), .v(fv), .s(fs));
   
   flag_reg f3(.clk(clk), .reset(reset), .sst(sst), 
               .c(fc), .z(fz), .v(fv), .s(fs), 
               .flag_c(c), .flag_z(z), .flag_v(v), .flag_s(s));
   
   timer f4(.clk(clk), .reset(reset), .ins(data_bus), .out(tim));
   reg_testa f5(.clk(clk), .reset(reset), 
                .input_a(tim), .input_b(alu_func), .input_c(alu_in_sel), 
                .cin(alu_cin), .rec(rec), 
                .pc_en(en_pc), .reg_en(en_reg_mux), .q(reg_test));
   
   
   t1 f7(.flag_c(c), .sci(sci), .alu_cin(alu_cin));
   t2 f8(.offset_8(offset_8), .offset_16(offset_16));
   t3 f9(.wr(wr), .alu_out(alu_out), .out(data_bus));
   
	ir f6(.clk(clk), .reset(reset), 
         .mem_data(data_bus), .rec(rec),  
         .q(instruction));
   ar f10(.clk(clk), .reset(reset), 
          .alu_out(alu_out), .pc(pc_bus), 
          .rec(rec),  .q(address_bus));
   pc f11(.clk(clk), .reset(reset), 
          .alu_out(alu_out), .en(en_pc),  
          .q(pc_bus));
   reg_out f12(.ir(instruction), .pc(pc_bus), .reg_in(reg_inout), .offset(offset_16), 
               .alu_a(alu_sr), .alu_b(alu_dr), .alu_out(alu_out), 
               .reg_testa(reg_test), .reg_sel(reg_sel), .sel(sel), .reg_data(reg_data));
   
	generate
	  genvar i;
	  for (i=0; i<16; i=i+1) begin : dff
		 register ri(.clk(clk), .reset(reset), 
		 .en(en_reg[i]), .d(alu_out), 
		 .q(reg_group[(i+1)*16-1-:16]));
	  end
	endgenerate
   
   reg_mux rm(.reg_group(reg_group), .dest_reg(d_reg), .sour_reg(s_reg), .reg_sel(reg_sel), 
              .en_reg_mux(en_reg_mux), .en_reg(en_reg),
              .dr(dr), .sr(sr), .reg_out(reg_inout));
	
   bus_mux bm(.alu_in_sel(alu_in_sel), .data(data_bus), 
				  .pc(pc_bus), .offset(offset_16), 
				  .sr(sr), .dr(dr), .alu_sr(alu_sr), .alu_dr(alu_dr),
				  .imm(imm));
	
endmodule
