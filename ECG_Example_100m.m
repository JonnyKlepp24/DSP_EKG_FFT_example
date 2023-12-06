% ECG_Example_100m
close all ; clear all ; clc ;


%% load signal
load('./ECG_Example_100m.mat') ;


%% settings
X = ECGsignal ;
Fs = fsampling;            % Sampling frequency                    
T = 1/Fs;                  % Sampling period       
L = length(X);             % Length of signal
t = (0:L-1)*T;             % Time vector


%% remove mean
X = X-mean(X);
normX = X/max(abs(X)); % make amp max 1


%% plot signal
figure()

subplot(2,1,1)
hold on;
plot(t,normX)
title('ECG signal example')

subplot(2,1,2)
hold on;
plot(t,normX)
title('ECG signal example')
xlim([4 6])


%% fft
X_fft = fft(X);

Nbins = length(X_fft);
n = (0:Nbins-1);   


% x-axis (Omega)
f_axis = n*(2*pi)/Nbins ; % Fs*(0:N-1)/N


figure()
stem( f_axis/pi , abs(X_fft) , 'r.','MarkerSize',12)
xlabel('Omega/pi') 
ylabel('|fft(x[n])|') 


% x-axis (frequency)
f_axis = (n*fsampling)/Nbins ;


figure()
stem( f_axis , abs(X_fft) , 'r.','MarkerSize',12)
xlabel('freq. (Hz)') 
ylabel('|fft(x[n])|') 

%% rectangle window at 25 hz

fc = 45;
recWindow = zeros(1,length(X_fft));
[amp_aux index_aux] = min(abs(f_axis-fc))
recWindow(1:index_aux) = 1;
recWindow(1,end-index_aux-1:end)=1;


signal_filt = X_fft.*recWindow;
%%plot


figure(); hold on;
plot( f_axis , abs(X_fft))
plot(f_axis,recWindow*max(abs(X_fft)))
plot(f_axis,abs(signal_filt))


%% go back

x_filt = ifft(signal_filt)

%% plot signal
subplot(2,1,1)
plot(t,real(x_filt))
title('ECG signal example')

subplot(2,1,2)
plot(t,real(x_filt))
title('ECG signal example')
xlim([4 6])







