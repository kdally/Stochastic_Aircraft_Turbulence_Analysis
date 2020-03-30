function [var] = variance_analytical(Sxx,w)

% This function computes the variance based on the analytical PSD

%%% Using Euler forward integration
% Nomega = size(w,2);
% var = zeros(1,5);
% for i = 1:(Nomega-1)
%     var = var+(w(i+1)-w(i))*Sxx(i,:) ;
% end
% var = var/pi;

%%% Using more accurate trapezoidal method
var = trapz(w,Sxx)/pi;

end

