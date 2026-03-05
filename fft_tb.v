`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2026 21:42:03
// Design Name: 
// Module Name: fft_tb
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


module fft_tb();
// Inputs
reg clk;
reg signed [15:0] data_in;

// Outputs
wire [31:0] data_out;
wire valid_out;

// Memory for input samples
reg signed [15:0] signal_mem [0:1023];

// Variables
integer i;
integer file;
integer r;
integer fft_file;

// Instantiate DUT
fft_top uut (
.clk(clk),
.data_in(data_in),
.data_out(data_out),
.valid_out(valid_out)
);

// Clock generation
initial clk = 0;
always #5 clk = ~clk;

// Initialize input
initial begin
data_in = 0;
end

// Open output file
initial begin
fft_file = $fopen("fft_output.txt","w");
end

// Write FFT output
always @(posedge clk) begin
if(valid_out)
$fwrite(fft_file,"%d\n",data_out);
end

// Main test process
initial begin

// Open input file
file = $fopen("input_signal.txt","r");

if(file == 0) begin
    $display("ERROR: input_signal.txt not found");
    $finish;
end
else
    $display("FILE OPENED SUCCESSFULLY");


// Read samples from file
for(i = 0; i < 1024; i = i + 1) begin

    if($feof(file)) begin
        $display("ERROR: Not enough samples in input file");
        $finish;
    end

    r = $fscanf(file,"%d", signal_mem[i]);

end

$fclose(file);


// Feed samples to FFT
for(i = 0; i < 1024; i = i + 1) begin
    @(posedge clk);
    data_in <= signal_mem[i];
end


// Wait for FFT pipeline
#500000;

$finish;

end
endmodule
