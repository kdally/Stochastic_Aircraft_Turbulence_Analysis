function [cit_fb] = build_state_space(Kt,Kq)

% File based on Example 7.6, Aircraft Responses to Atmospheric Turbulence cit2s.m
% Coefficients are from the assignment
%
% This file stores a/c and turbulence parameters and buids the corresponding state-space model.
% The state space system corresponds to longitudinal motions supplemented by a Dryden turbulence model.
%
%  Cessna Citation Ce-500, cruise
%
% INPUT TURBULENCE- AND AIRCRAFT PARAMETERS

% AIRCRAFT FLIGHT CONDITION 'CRUISE'.
xcg = 0.3; %percentage of chord
W   = 53361; %N
m   = 5445; %kg
S   = 24.2; %m^2
c   = 2.022; %m
b   = 13.36; %m
V   = 121.3; %m/s
h   = 9144; %m
rho = 0.4587; %kg/m^3
g_0 = 9.80665; %kg/m^s
muc = 209;
twmuc = 2*muc;
KY2   = 0.950;
lh    = 5.5;


% TURBULENCE PARAMETERS
Lg    = 150; %m
sigmaug = 2; %m/s
sigmavg = 0; %m/s
sigmawg = 3; %m/s
sigmaug_V = sigmaug/V; 
sigmaag   = sigmawg/V;


% AIRCRAFT SYMMETRIC AERODYNAMIC DERIVATIVES : 
CX0 = 0.0000;     CZ0  =-0.5640;     Cm0  =  0.0000;
CXu =-0.0850;     CZu  =-1.1280;     Cmu  =  0.0000;
CXa = 0.2140;     CZa  =-5.4300;     Cma  = -0.5180;
CXq = 0.0000;     CZq  =-4.0700;     Cmq  = -7.350;
CXd = 0.0000;     CZd  =-0.5798;     Cmd  = -1.4440;
CXfa= 0.0000;     CZfa =-1.6200;     Cmfa = -4.2000;
                  CZfug= 0.0000;     Cmfug= -Cm0*lh/c;
                  CZfag= CZfa-CZq;   Cmfag=  Cmfa-Cmq;

% CALCULATION OF AIRCRAFT SYMMETRIC STABILITY DERIVATIVES
xu   = (V/c)*(CXu/twmuc);
xa   = (V/c)*(CXa/twmuc);
xt   = (V/c)*(CZ0/twmuc);
xq   = 0;
xd   = (V/c)*(CXd/twmuc);
xug  = xu;
xfug = 0;
xag  = xa;
xfag = 0;

zu   = (V/c)*( CZu/(twmuc-CZfa));
za   = (V/c)*( CZa/(twmuc-CZfa));
zt   = (V/c)*(-CX0/(twmuc-CZfa));
zq   = (V/c)*((CZq+twmuc)/(twmuc-CZfa));
zd   = (V/c)*( CZd/(twmuc-CZfa));
zug  = zu;
zfug = (V/c)*( CZfug/(twmuc-CZfa));
zag  = za;
zfag = (V/c)*( CZfag/(twmuc-CZfa));

mu   = (V/c)*(( Cmu+CZu*Cmfa/(twmuc-CZfa))/(twmuc*KY2));
ma   = (V/c)*(( Cma+CZa*Cmfa/(twmuc-CZfa))/(twmuc*KY2));
mt   = (V/c)*((-CX0*Cmfa/(twmuc-CZfa))/(twmuc*KY2));
mq   = (V/c)*(Cmq+Cmfa*(twmuc+CZq)/(twmuc-CZfa))/(twmuc*KY2);
md   = (V/c)*((Cmd+CZd*Cmfa/(twmuc-CZfa))/(twmuc*KY2));
mug  = mu;
mfug = (V/c)*(Cmfug+CZfug*Cmfa/(twmuc-CZfa))/(twmuc*KY2);
mag  = ma;
mfag = (V/c)*(Cmfag+CZfag*Cmfa/(twmuc-CZfa))/(twmuc*KY2);

% STATE- AND INPUT MATRICES
A=[xu xa xt 0    xug                  xag       0;
   zu za zt zq   zug-zfug*V/Lg*(c/V)  zag       zfag*(c/V);
   0  0  0  V/c  0                    0         0;
   mu ma mt mq   mug-mfug*V/Lg*(c/V)  mag       mfag*(c/V);
   0  0  0  0   -V/Lg                 0         0;
   0  0  0  0    0                    0         1;
   0  0  0  0    0                   -(V/Lg)^2 -2*V/Lg];

B=...
 [xd 0                                 0;
  zd zfug*(c/V)*sigmaug_V*sqrt(2*V/Lg) zfag*(c/V)*sigmaag*sqrt(3*V/Lg);
  0  0                                 0;
  md mfug*(c/V)*sigmaug_V*sqrt(2*V/Lg) mfag*(c/V)*sigmaag*sqrt(3*V/Lg);
  0  sigmaug_V*sqrt(2*V/Lg)            0;
  0  0                                 sigmaag*sqrt(3*V/Lg);
  0  0                                 (1-2*sqrt(3))*sigmaag*sqrt((V/Lg)^3)];

% OUTPUT MATRICES WITH LOAD FACTOR
C = [eye(4) zeros(4,3)];                         % only output a/c states
C(end+1,:) = V/g_0*([0 0 0 V/c 0 0 0] - A(2,:)); % append the load factor
D = zeros(size(C, 1),size(B, 2)); 
D(end,:) = -V/g_0*B(2,:);                        % append the load factor

% FEEDBACK MATRIX AND NEW STATE MARIX
% IN CASE OF OPEN LOOP, ALL GAINS ARE ZERO AND At = A
K = zeros(size(B,2),size(A,1));                  % feedback matrix
K(1,:) = [0 0 Kt Kq 0 0 0];  
A_fb = A-B*K;                                    % new feedback state matrix

% STATE SPACE WITH FEEDBACK, UNLESS GAINS ARE ALL ZEROS
cit_fb = ss(A_fb, B, C, D);
cit_fb.StateName    = {'u','\alpha','\theta','qc/V','u_g','alpha_g','alpha_g_dot'};
cit_fb.InputName    = {'\delta_{el}','w1','w3'};
cit_fb.OutputName   = {'u','\alpha','\theta','qc/V','n_z'};

