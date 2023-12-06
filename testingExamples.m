%%testingExamples

%% FFTs and windowing
close all ; clear all; clc;

Fs = 360; % Sampling frequency
T = 1/Fs; % Sampling period
%% filter settings
N = 34 ; % Length of filter
t = (0:N-1)*T; % Time vector
f = Fs*(0:N-1)/N;
%% filter in the freq domain
fc = 25 ;
rectangular_window = zeros(1,N);
[amp_aux indx_aux] = min( abs(f-fc) );
rectangular_window(1:indx_aux)=1;
rectangular_window(1,end-indx_aux+1:end)=1;
figure()
hold on;
plot(f,rectangular_window)
title("Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
ylabel("|X(omega)|")
%% ifft - rectangular window
rect_wind_time = ifft(rectangular_window);
figure()
plot(real(rect_wind_time))
rectangular_window_shift = circshift( rect_wind_time , length(rect_wind_time)/2) ;
figure()
plot(real(rectangular_window_shift))
%% fft - rectangular window with number of samples of the signal
N_samples_signal = 3600 ;
rectangular_window_shift_fft = fft(rectangular_window_shift,N_samples_signal) ;
figure()
plot( abs(rectangular_window_shift_fft) )
%% window
w = hamming(N).';
figure()
plot(w)
%% sinc and window
rectangular_window_shift_window = rectangular_window_shift.*w ;
figure()
plot(real(rectangular_window_shift_window))
%% ifft - rectangular window and window
N_samples_signal = 3600 ;
rectangular_window_shift_window_fft = ...
fft(rectangular_window_shift_window,N_samples_signal) ;
figure()
plot( abs(rectangular_window_shift_window_fft) )
%% comparison
figure(); hold on ;
plot( abs(rectangular_window_shift_fft))
plot( abs(rectangular_window_shift_window_fft) )


