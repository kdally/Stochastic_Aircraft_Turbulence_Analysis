function [Sxx, w, N] = psd_experimental_smooth_hanning(sys, u_turb,T,dt)

% This function computes the smoothed-experimental periodogram with window
% function

[Sxx, w, N] = psd_experimental_fft_hanning(sys, u_turb,T,dt);

for k = [2:(size(Sxx,1)-1)]
    Sxx(k,:) = 0.25*Sxx(k-1,:)+0.5*Sxx(k,:)+0.25*Sxx(k+1,:);
end

end

