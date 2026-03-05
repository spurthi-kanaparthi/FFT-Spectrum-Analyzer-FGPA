fs = 8000;              % Sampling frequency
t = (0:1023)/fs;      % Correct time vector

f1 = 1000;
f2 = 2000;

signal = sin(2*pi*f1*t) + sin(2*pi*f2*t);

% ----- limit samples to FFT size -----
signal = signal(1:1024);

plot(signal)
title('Time Domain Signal')

% ----- MATLAB FFT (for verification) -----

N = length(signal);
fft_signal = fft(signal);

f = (0:N-1)*(fs/N);

figure
plot(f, abs(fft_signal))
title('MATLAB Frequency Spectrum')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([0 4000])
grid on

% ----- write input file -----
signal_fixed = round(signal * 16000);

fid = fopen('input_signal.txt','w');
fprintf(fid,'%d\n',signal_fixed);
fclose(fid);

% ----- FFT OUTPUT ANALYSIS -----

fft_raw = int32(load('fft_output.txt'));
fft_raw = fft_raw(1:1024);

% extract real and imaginary parts
real_part = bitshift(fft_raw,-16);
imag_part = bitand(fft_raw,65535);

% convert to signed values
real_part(real_part > 32767) = real_part(real_part > 32767) - 65536;
imag_part(imag_part > 32767) = imag_part(imag_part > 32767) - 65536;

% compute magnitude
fft_mag = sqrt(double(real_part).^2 + double(imag_part).^2);

% normalize
fft_mag = fft_mag / max(fft_mag);

FFT_SIZE = 1024;

% take half spectrum
fft_mag = fft_mag(1:FFT_SIZE/2);

f_axis = (0:FFT_SIZE/2-1)*(fs/FFT_SIZE);

figure
stem(f_axis,fft_mag,'filled')
title('FFT Spectrum Analyzer Output')
xlabel('Frequency (Hz)')
ylabel('Normalized Magnitude')
grid on
xlim([0 4000])