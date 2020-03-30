function [var] = variance_impulse(sys, gust_type)

% This function computes the variance based on the impulse response method

dt = 0.01; % Time step
t_max = 600;
t = [0:dt:t_max];
u = zeros(3,size(t,2));

% mimic impulse with initial conditions
if strcmp(gust_type,'horz')
    x_0 = sys.B(:,2);
elseif strcmp(gust_type,'vert')
    x_0 = sys.B(:,3);
end
 
h = lsim(sys, u, t, x_0);
h2 = h.*h;

var = trapz(t,h2); % trapezoidal method for integration

end

