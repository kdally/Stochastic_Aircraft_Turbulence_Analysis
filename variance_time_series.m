function [var2] = variance_time_series(sys, u_turb,t_max,dt)

% This function computes the variance based on the time response of the system

t = [0:dt:t_max];
y_lsim = lsim(sys, u_turb, t);
var2 = var(y_lsim);

end

