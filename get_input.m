function [u_turb_h, u_turb_v] = get_input(t_max,dt)

% This function creates white noise signal inputs based on a given simulation time and time step

t = [0:dt:t_max];

% two types of input signals, one for horizontal turbulence and one for vertical turbulence
% uses random numbers from the standard normal distribution, randn(1,N)
u_turb_h = [zeros(1, size(t,2)); randn(1, size(t,2))/sqrt(dt); zeros(1, size(t,2))];
u_turb_v = [zeros(1, size(t,2)); zeros(1, size(t,2));   randn(1, size(t,2))/sqrt(dt)];

end

