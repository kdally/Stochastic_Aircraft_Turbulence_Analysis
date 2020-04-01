% Stochastic Aerospace Systems Practical Assignment
% Code from Killian Dally (4553373)
% April 2020
%
% Note: 'horz' refers to the horizontal disturbance case
%       'vert' refers to the horizontal disturbance case
%        Plots are not shown by default, but saved in the folder 'Plots'

%% STABILITY ANALYSIS

clear;
% Open-loop system 
Kt = 0 ; Kq = 0;                                   % Open-loop, all gains are zero
cit_open = build_state_space(Kt,Kq);               % Load data and build state space system (including load factor)
[freq_cit_open, damp_cit_open, poles_cit_open] = damp(cit_open);

% Find the gains
tune_gain_rlocus(cit_open,'\theta','\delta_{el}'); % Root-locus method with SISO sub-model
Kt = -0.061572 ; Kq = 0;                           % Closed-loop gains

% Closed-loop system
cit = build_state_space(Kt,Kq);
[freq_cit, damp_cit, poles_cit] = damp(cit);       % Check stability and damping of closed-loop 
plot_poles_zeros_map(cit,cit_open);                % Plot the pole-zero map


%% TIME DOMAIN ANALYSIS

Fs = 100;                                % Sampling frequency
T = 700; dt = 1/Fs;                      % T is simulation time, dt is time step
load u_turb.mat;                         % Import white noise input, for the same results as shown in report
%[u_turb_h, u_turb_v] = get_input(T,dt); % Generate new white noise input

plot_time_response(cit, u_turb_h, 'horz',T,dt);
plot_time_response(cit, u_turb_v, 'vert',T,dt);


%% SPECTRAL ANALYSIS

% Analytical spectrum
[Sxx_h, ~] = psd_analytical(cit, 'horz');
[Sxx_v, w_a] = psd_analytical(cit, 'vert');                 % w_a is the pseudo-continuous frequency axis
 
% Fast Fourier Transform
[Pxx_h, ~]    = psd_experimental_fft(cit, u_turb_h,T,dt);
[Pxx_v, w_e, N] = psd_experimental_fft(cit, u_turb_v,T,dt); % w_e is the dicrete frequency axis, N number of samples

% Smoothing 
[Pxxs_h, ~]    = psd_experimental_smooth(cit, u_turb_h,T,dt);
[Pxxs_v, w_es, ~] = psd_experimental_smooth(cit, u_turb_v,T,dt);

% Fast Fourier Transform with Hanning Window 
[Pxx_h_hann, ~]    = psd_experimental_fft_hanning(cit, u_turb_h,T,dt);
[Pxx_v_hann, ~, ~] = psd_experimental_fft_hanning(cit, u_turb_v,T,dt); 

% Smoothing with Hanning Window
[Pxxs_h_hann, ~]    = psd_experimental_smooth_hanning(cit, u_turb_h,T,dt);
[Pxxs_v_hann, ~, ~] = psd_experimental_smooth_hanning(cit, u_turb_v,T,dt);

% Plotting
plot_psd_comp(Sxx_h, w_a, Pxx_h, w_e, Pxxs_h, w_es, 'horz','');
plot_psd_comp(Sxx_v, w_a, Pxx_v, w_e, Pxxs_v, w_es, 'vert','');
plot_psd_comp(Sxx_h, w_a, Pxx_h_hann, w_e, Pxxs_h_hann, w_es, 'horz','_hann');
plot_psd_comp(Sxx_v, w_a, Pxx_v_hann, w_e, Pxxs_v_hann, w_es, 'vert','_hann');


%% VARIANCES

% Using the analytical power sprectrum
var_h = variance_analytical(Sxx_h,w_a);
var_v = variance_analytical(Sxx_v,w_a);

% Using the impulse response method
var_h2 = variance_impulse(cit, 'horz');
var_v2 = variance_impulse(cit, 'vert');

% Using routine var.m on time series
var_h3 = variance_time_series(cit, u_turb_h,T,dt);
var_v3 = variance_time_series(cit, u_turb_v,T,dt);


%% OTHER PLOTS

addpath('Extra plots/');
plot_time_response_comp(cit, u_turb_h, u_turb_v,T,dt);
plot_psd(Pxxs_h, w_es, 'horz_smooth');
plot_psd(Pxxs_v, w_es, 'vert_smooth');
plot_psd(Sxx_h, w_a, 'horz_ana');
plot_psd(Sxx_v, w_a, 'vert_ana');
plot_psd(Pxx_h(1:round(N/2)-1,:), w_e, 'horz_fft');
plot_psd(Pxx_v(1:round(N/2)-1,:), w_e, 'vert_fft');
