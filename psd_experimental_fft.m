function [Sxx, w, N] = psd_experimental_fft(sys, u_turb,T,dt)

% File based on Example 7.4b, Aircraft Responses to Atmospheric Turbulence (exampl74b.m)
% This function computes the experimental periodogram

t = [0:dt:T];
N = size(t,2);
fs = 1/dt;
w = 2*pi*fs*(0:(N/2)-1)/N;

y_1 = lsim(sys, u_turb, t);

% FFT ALL SIGNALS AND COMPUTE EXPERIMENTAL POWER SPECTRAL DENSITIES
temp = fft(y_1(:,1)) ; Iuu = temp.*conj(temp)/N ; % using the definition of slides of lecture 4
temp = fft(y_1(:,2)) ; Iaa = temp.*conj(temp)/N ;
temp = fft(y_1(:,3)) ; Itt = temp.*conj(temp)/N ;
temp = fft(y_1(:,4)) ; Iqq = temp.*conj(temp)/N ;
temp = fft(y_1(:,5)) ; Izz = temp.*conj(temp)/N ;

% again, using the definition of the slides of lecture 4, to convert to a
% continuous frequency axis
Sxx = dt*([Iuu(1:round(N/2)-1,:) Iaa(1:round(N/2)-1,:) Itt(1:round(N/2)-1,:) Iqq(1:round(N/2)-1,:) Izz(1:round(N/2)-1,:)]);

end

