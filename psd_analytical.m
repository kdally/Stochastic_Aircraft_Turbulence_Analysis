function [Sxx,w] = psd_analytical(sys1, gust_type)

% File based on Example 8.3, Aircraft Responses to Atmospheric Turbulence (exampl83.m)
% This function computes the analytical power spectrum density

w = logspace (-2, 2, 300); % pseudo-contiuous frequency axis

if strcmp(gust_type,'horz')
    gust = 2;
elseif strcmp(gust_type,'vert')
    gust = 3;
end
    
% COMPUTE ANALYTIC POWER SPECTRAL DENSITIES
temp = bode(sys1.A,sys1.B,sys1.C(1,:), sys1.D(1,:), gust, w) ; Suu = temp.*temp ; % only real signals obained because bode outputs the magnitude
temp = bode(sys1.A,sys1.B,sys1.C(2,:), sys1.D(2,:), gust, w) ; Saa = temp.*temp ;
temp = bode(sys1.A,sys1.B,sys1.C(3,:), sys1.D(3,:), gust, w) ; Stt = temp.*temp ;
temp = bode(sys1.A,sys1.B,sys1.C(4,:), sys1.D(4,:), gust, w) ; Sqq = temp.*temp ;
temp = bode(sys1.A,sys1.B,sys1.C(5,:), sys1.D(5,:), gust, w) ; Szz = temp.*temp;
Sxx = [Suu Saa Stt Sqq Szz];

end

