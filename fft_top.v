`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2026 21:39:46
// Design Name: 
// Module Name: fft_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fft_top(
    input clk,
    input [15:0] data_in,
    output [31:0] data_out,
    output valid_out
    );

wire [31:0] fft_out;
wire s_axis_data_tready;
wire s_axis_config_tready;

reg [9:0] sample_cnt = 10'd0;
reg tlast = 1'b0;


// Generate TLAST every 1024 samples
always @(posedge clk)
begin
    if(sample_cnt == 10'd1023)
    begin
        sample_cnt <= 10'd0;
        tlast <= 1'b1;
    end
    else
    begin
        sample_cnt <= sample_cnt + 1'b1;
        tlast <= 1'b0;
    end
  end
reg [15:0] config_tdata = 16'd0;
reg config_tvalid = 1'b1;
 always@(posedge clk)
 begin
     if(s_axis_config_tready)
     config_tvalid <= 1'b0;
 end
// FFT IP
xfft_0 fft_inst (

    .aclk(clk),
    
    .s_axis_config_tdata(config_tdata),
    .s_axis_config_tvalid(config_tvalid),
    .s_axis_config_tready(s_axis_config_tready),
    .s_axis_data_tdata({16'b0,data_in}),
    .s_axis_data_tvalid(1'b1),     // data always valid
    .s_axis_data_tlast(tlast),
    .s_axis_data_tready(s_axis_data_tready),

    .m_axis_data_tdata(fft_out),
    .m_axis_data_tvalid(valid_out),
    .m_axis_data_tready(1'b1)
);


// Output assignment
assign data_out = valid_out ? fft_out : 32'd0;

endmodule
