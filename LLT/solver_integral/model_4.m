function status_d = model_4(t,status,parameters)

    r       =status(1);
    theta   =status(2);
    phi     =status(3);
    v       =status(4);
    gamma   =status(5);
    psi     =status(6);

parameters_user_3
load fitAOA_Ma_CdCl
status_d = zeros(6,1);


[fitresult_Cl, ~]= createFit_Cl(x,y,z1);
[fitresult_Cd ,~]= createFit_Cd(x,y,Z2);

alpha = parameters(1);
sigma = parameters(2);
m  = parameters(3);
Ma = v/340;

rou = rou_0 * exp(-(r - R_0)/H);
C_d = fitresult_Cd(alpha,Ma);
C_l = fitresult_Cl(alpha,Ma);


D = 0.5 * rou * v^2 * S_ref * C_d;
L = 0.5 * rou * v^2 * S_ref * C_l;
g = miu/r^2;


% r_d = v * sin(gamma);
r_d = v*sin(gamma);

theta_d = v * cos(gamma) * sin(psi)/(r*cos(phi));
phi_d = v * cos(gamma)*cos(psi)/r;
v_d = -D/m - g*sin(gamma)+omega^2 * r * cos(phi) * (sin (gamma) * cos (phi) - cos(gamma) * cos(psi) * sin(phi));
gamma_d = L*cos(sigma)/(m*v) - (g/v - v/r)*cos(gamma) + 2* omega * sin(psi) * cos(phi) + omega^2 * r * cos(phi)*(cos(gamma)*cos(phi)+sin(gamma)*cos(psi)*sin(phi))/v;
psi_d = L*sin(sigma)/(m*v*cos(gamma)) +(v/r) *cos(gamma)*sin(psi)*tan(phi) - 2*omega*(tan(gamma)*cos(psi)*cos(phi)-sin(phi))+omega^2*(r/(v*cos(gamma))) *sin(psi) *sin(phi)*cos(phi);
gamma
status_d(1) = r_d;
status_d(2) = theta_d;
status_d(3) = phi_d;
status_d(4) = v_d;
status_d(5) = gamma_d;
status_d(6) = psi_d;