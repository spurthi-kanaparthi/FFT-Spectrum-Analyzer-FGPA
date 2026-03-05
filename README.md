# FFT Based Real-Time Spectrum Analyzer using FPGA
## Project Overview
This project implements a Real-Time Spectrum Analyzer using a 1024-point Fast Fourier Transform (FFT) on a Xilinx FPGA.
The system generates a test signal in MATLAB, processes it through an FFT implemented in Verilog using the Xilinx FFT IP Core, and analyzes the output spectrum again in MATLAB.
The goal of this project is to demonstrate frequency-domain analysis of signals using FPGA hardware acceleration.
System Architecture
## Signal processing flow:

MATLAB Signal Generation
        ↓
Input Samples (input_signal.txt)
        ↓
Verilog Testbench
        ↓
Xilinx FFT IP Core (1024-point FFT)
        ↓
FFT Output Data (fft_output.txt)
        ↓
MATLAB Spectrum Visualization

## Tools and Technologies
Xilinx Vivado – FPGA design and simulation
Verilog HDL – Hardware description language for FPGA implementation
MATLAB – Signal generation and FFT output analysis
Xilinx FFT IP Core – High-performance FFT processing block
Input Signal
The input test signal is composed of two sinusoidal frequencies:
Frequency 1 = 1000 Hz
Frequency 2 = 2000 Hz
Sampling frequency:
Fs = 8000 Hz
Signal equation:
x(t) = sin(2πf1t) + sin(2πf2t)
## Project Files
File Description
### fft_top.v
Top-level Verilog module connecting the FFT IP core
### fft_tb.v
Testbench for simulation
### xfft_0.xci
Xilinx FFT IP core configuration
### fft_project.m
MATLAB script for signal generation and FFT output analysis
### input_signal.txt
Generated input samples for FPGA
### fft_output.txt
FFT output data generated during simulation
## README.md
Project documentation
Output Results
The FFT spectrum shows peaks at:
1000 Hz
2000 Hz
This confirms that the FPGA FFT correctly detects the frequency components of the input signal.
# Applications
FFT-based spectrum analyzers are widely used in:
- Wireless communication systems
- Radar signal processing
- Audio signal analysis
- Biomedical signal processing
- Software-defined radio (SDR)
# Future Improvements
Possible extensions of this project:
> Implement real-time FPGA hardware testing on board
> Add UART or Ethernet interface for live data
> Display spectrum using MATLAB GUI or Python visualization
> Implement higher resolution FFT (2048 / 4096 points)

## Author
kanaparthi Sai Spurthi
Electronics / FPGA Enthusiast
