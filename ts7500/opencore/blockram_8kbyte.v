/* Copyright 2005-2007, Unpublished Work of Technologic Systems
 * All Rights Reserved.
 *
 * THIS WORK IS AN UNPUBLISHED WORK AND CONTAINS CONFIDENTIAL,
 * PROPRIETARY AND TRADE SECRET INFORMATION OF TECHNOLOGIC SYSTEMS.
 * ACCESS TO THIS WORK IS RESTRICTED TO (I) TECHNOLOGIC SYSTEMS 
 * EMPLOYEES WHO HAVE A NEED TO KNOW TO PERFORM TASKS WITHIN THE SCOPE
 * OF THEIR ASSIGNMENTS AND (II) ENTITIES OTHER THAN TECHNOLOGIC
 * SYSTEMS WHO HAVE ENTERED INTO APPROPRIATE LICENSE AGREEMENTS.  NO
 * PART OF THIS WORK MAY BE USED, PRACTICED, PERFORMED, COPIED, 
 * DISTRIBUTED, REVISED, MODIFIED, TRANSLATED, ABRIDGED, CONDENSED, 
 * EXPANDED, COLLECTED, COMPILED, LINKED, RECAST, TRANSFORMED, ADAPTED
 * IN ANY FORM OR BY ANY MEANS, MANUAL, MECHANICAL, CHEMICAL, 
 * ELECTRICAL, ELECTRONIC, OPTICAL, BIOLOGICAL, OR OTHERWISE WITHOUT
 * THE PRIOR WRITTEN PERMISSION AND CONSENT OF TECHNOLOGIC SYSTEMS.
 * ANY USE OR EXPLOITATION OF THIS WORK WITHOUT THE PRIOR WRITTEN
 * CONSENT OF TECHNOLOGIC SYSTEMS COULD SUBJECT THE PERPETRATOR TO
 * CRIMINAL AND CIVIL LIABILITY.
 */


module blockram_8kbyte(
  wb_clk_i,
  wb_rst_i,

  wb1_adr_i,
  wb1_dat_i,
  wb1_dat_o,
  wb1_cyc_i,
  wb1_stb_i,
  wb1_ack_o,
  wb1_we_i,
  wb1_sel_i,

  wb2_adr_i,
  wb2_dat_i,
  wb2_dat_o,
  wb2_cyc_i,
  wb2_stb_i,
  wb2_ack_o,
  wb2_we_i,
  wb2_sel_i,

  wb3_adr_i,
  wb3_dat_i,
  wb3_dat_o,
  wb3_cyc_i,
  wb3_stb_i,
  wb3_ack_o,
  wb3_we_i,
  wb3_sel_i,

  wb4_adr_i,
  wb4_dat_i,
  wb4_dat_o,
  wb4_cyc_i,
  wb4_stb_i,
  wb4_ack_o,
  wb4_we_i,
  wb4_sel_i,

  wb5_adr_i,
  wb5_dat_i,
  wb5_dat_o,
  wb5_cyc_i,
  wb5_stb_i,
  wb5_ack_o,
  wb5_we_i,
  wb5_sel_i,
  
);

input wb_clk_i, wb_rst_i;
input [31:0] wb1_adr_i, wb2_adr_i, wb3_adr_i, wb4_adr_i, wb5_adr_i;
input [31:0] wb1_dat_i, wb2_dat_i, wb3_dat_i, wb4_dat_i, wb5_dat_i;
input wb1_cyc_i, wb2_cyc_i, wb1_stb_i, wb2_stb_i, wb1_we_i, wb2_we_i;
input wb3_cyc_i, wb4_cyc_i, wb3_stb_i, wb4_stb_i, wb3_we_i, wb4_we_i;
input wb5_cyc_i, wb5_stb_i, wb5_we_i;
input [3:0] wb1_sel_i, wb2_sel_i, wb3_sel_i, wb4_sel_i, wb5_sel_i;
output [31:0] wb1_dat_o, wb2_dat_o, wb3_dat_o, wb4_dat_o, wb5_dat_o;
output wb1_ack_o, wb2_ack_o, wb3_ack_o, wb4_ack_o, wb5_ack_o;

reg wb1_ack, wbn_ack;
wire [31:0] wbn_dat, wbn_dat_i, wbn_adr_i;
wire wbn_cyc_i, wbn_stb_i, wbn_we_i;
wire [3:0] wbn_sel_i;

wb_arbiter arbitercore(
  .wb_clk_i(wb_clk_i),
  
  .wb1_cyc_i(wb2_cyc_i),
  .wb1_stb_i(wb2_stb_i),
  .wb1_adr_i(wb2_adr_i),
  .wb1_dat_i(wb2_dat_i),
  .wb1_dat_o(wb2_dat_o),
  .wb1_ack_o(wb2_ack_o),
  .wb1_sel_i(wb2_sel_i),
  .wb1_we_i(wb2_we_i),

  .wb2_cyc_i(wb3_cyc_i),
  .wb2_stb_i(wb3_stb_i),
  .wb2_adr_i(wb3_adr_i),
  .wb2_dat_i(wb3_dat_i),
  .wb2_dat_o(wb3_dat_o),
  .wb2_ack_o(wb3_ack_o),
  .wb2_we_i(wb3_we_i),
  .wb2_sel_i(wb3_sel_i),

  .wb3_cyc_i(wb4_cyc_i),
  .wb3_stb_i(wb4_stb_i),
  .wb3_adr_i(wb4_adr_i),
  .wb3_dat_i(wb4_dat_i),
  .wb3_dat_o(wb4_dat_o),
  .wb3_ack_o(wb4_ack_o),
  .wb3_we_i(wb4_we_i),
  .wb3_sel_i(wb4_sel_i),

  .wb4_cyc_i(wb5_cyc_i),
  .wb4_stb_i(wb5_stb_i),
  .wb4_adr_i(wb5_adr_i),
  .wb4_dat_i(wb5_dat_i),
  .wb4_dat_o(wb5_dat_o),
  .wb4_ack_o(wb5_ack_o),
  .wb4_we_i(wb5_we_i),
  .wb4_sel_i(wb5_sel_i),

  .wbowner_cyc_o(wbn_cyc_i),
  .wbowner_stb_o(wbn_stb_i),
  .wbowner_we_o(wbn_we_i),
  .wbowner_adr_o(wbn_adr_i),
  .wbowner_dat_o(wbn_dat_i),
  .wbowner_dat_i(wbn_dat),
  .wbowner_ack_i(wbn_ack),
  .wbowner_sel_o(wbn_sel_i)
);


reg [31:0] blockram_data_i;
reg [10:0] blockram_rdadr_i, blockram_wradr_i;
wire [31:0] blockram_data_o;
reg [3:0] blockram_wren;

lattice_ram blockram0 (
  .WrAddress(blockram_wradr_i),
  .RdAddress(blockram_rdadr_i),
  .Data(blockram_data_i[7:0]),
  .RdClock(wb_clk_i),
  .RdClockEn(1'b1),
  .Reset(1'b0),
  .WrClock(wb_clk_i),
  .WrClockEn(blockram_wren[0]),
  .WE(1'b1),
  .Q(blockram_data_o[7:0])
);
lattice_ram blockram1 (
  .WrAddress(blockram_wradr_i),
  .RdAddress(blockram_rdadr_i),
  .Data(blockram_data_i[15:8]),
  .RdClock(wb_clk_i),
  .RdClockEn(1'b1),
  .Reset(1'b0),
  .WrClock(wb_clk_i),
  .WrClockEn(blockram_wren[1]),
  .WE(1'b1),
  .Q(blockram_data_o[15:8])
);
lattice_ram blockram2 (
  .WrAddress(blockram_wradr_i),
  .RdAddress(blockram_rdadr_i),
  .Data(blockram_data_i[23:16]),
  .RdClock(wb_clk_i),
  .RdClockEn(1'b1),
  .Reset(1'b0),
  .WrClock(wb_clk_i),
  .WrClockEn(blockram_wren[2]),
  .WE(1'b1),
  .Q(blockram_data_o[23:16])
);
lattice_ram blockram3 (
  .WrAddress(blockram_wradr_i),
  .RdAddress(blockram_rdadr_i),
  .Data(blockram_data_i[31:24]),
  .RdClock(wb_clk_i),
  .RdClockEn(1'b1),
  .Reset(1'b0),
  .WrClock(wb_clk_i),
  .WrClockEn(blockram_wren[3]),
  .WE(1'b1),
  .Q(blockram_data_o[31:24])
);

reg rdowner = 1'b0;	//SBUS is reading when 1, otherwise internal read
reg wrowner = 1'b0;	//SBUS is writing when 1, otherwise internal write
reg wb1_rdreq, wbn_rdreq, wb1_wrreq, wbn_wrreq;

always @(rdowner or wrowner or wb1_adr_i or wbn_adr_i or wb1_dat_i
  or wbn_dat_i or wb1_sel_i or wbn_sel_i or wbn_wrreq or wb1_wrreq) begin

  //Read address handler
  if (rdowner) begin
	  blockram_rdadr_i = wbn_adr_i >> 2;
  end else begin
	  blockram_rdadr_i = wb1_adr_i >> 2;
  end

  blockram_wren = 4'b0000;
  
  //Write address handler
  if (wrowner) begin
	  
    blockram_wradr_i = wbn_adr_i >> 2;
    blockram_data_i = wbn_dat_i;
      
	if (wbn_wrreq) begin
		blockram_wren = wbn_sel_i;
	end
	
  end else begin
    
	blockram_wradr_i = wb1_adr_i >> 2;
    blockram_data_i = wb1_dat_i;
    
	if (wb1_wrreq) begin
		blockram_wren = wb1_sel_i;
	end
		
  end
  
end

assign wb1_dat_o = blockram_data_o;
assign wbn_dat = blockram_data_o;

// Read/Write operation and request handler

always @(wb1_cyc_i or wb1_stb_i or wb1_we_i or wb_rst_i or
  wbn_cyc_i or wbn_stb_i or wbn_we_i or rdowner or wrowner or
  wb1_ack or wbn_ack) begin
	  
  wb1_rdreq = wb1_cyc_i && !wb1_we_i;
  wbn_rdreq = wbn_cyc_i && wbn_stb_i && !wbn_we_i && !wbn_ack;
  wb1_wrreq = wb1_cyc_i && wb1_we_i;
  wbn_wrreq = wbn_cyc_i && wbn_stb_i && wbn_we_i && !wbn_ack;

  if (rdowner) begin
    if (wb1_rdreq && !wbn_rdreq) begin
		rdowner = 1'b0;
	end else begin
		rdowner = 1'b1;
	end
  end else begin
    if (!wb1_rdreq && wbn_rdreq) begin
		rdowner = 1'b1;
    end else begin
		rdowner = 1'b0;
	end
  end

  if (wrowner) begin
    if (wb1_wrreq && !wbn_wrreq) begin
		wrowner = 1'b0;
	end else begin
		wrowner = 1'b1;
	end
  end else begin
    if (!wb1_wrreq && wbn_wrreq) begin
		wrowner = 1'b1;
	end else begin
		wrowner = 1'b0;
	end
  end

  if (wb_rst_i) begin
    rdowner = 1'b0;
    wrowner = 1'b0;
  end
end

//Ack handler

always @(posedge wb_clk_i) begin
	
  wb1_ack <= 1'b0;
  wbn_ack <= 1'b0;
  
  if (wb1_rdreq && !rdowner && !wb1_ack && wb1_stb_i) begin
    wb1_ack <= 1'b1;
  end else if (wbn_rdreq && rdowner && !wbn_ack) begin
    wbn_ack <= 1'b1;
  end

  if (wb1_wrreq && !wrowner && !wb1_ack && wb1_stb_i) begin
    wb1_ack <= 1'b1;
  end else if (wbn_wrreq && wrowner && !wbn_ack) begin
    wbn_ack <= 1'b1;
  end
  
end

assign wb1_ack_o = wb1_ack;

endmodule

