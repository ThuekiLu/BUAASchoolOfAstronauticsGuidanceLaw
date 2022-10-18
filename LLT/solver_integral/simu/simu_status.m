function status_d = simu_status(t,status,alpha,beta,m)

%这是进一步考虑飞行器气动特性的平面大地三维质点动力学模型；
%攻角和侧滑角：alpha 和 beta 为主要输入；
%status = [x y z V gamma psi]；
%
parameters_user_2
status_d = zeros(6,1);
rou = rou_0 * exp(-status(3)/H);

C_d = 0.000508 * (alpha^2 + beta^2) + 0.004228 * (alpha^2 + beta^2)^(1/2) + 0.0161;
C_l = 0.04675 * alpha - 0.10568;
C_n = 0.04675 * beta - 0.10568;

D = 0.5 * rou * status(4)^2 * S_ref * C_d;
L = 0.5 * rou * status(4)^2 * S_ref * C_l;
N = 0.5 * rou * status(4)^2 * S_ref * C_n; 

status_d(1) = status(4) * cos(status(5)) * sin(status(6));
status_d(2) = status(4) * cos(status(5)) * cos(status(6));
status_d(3) = status(4) * sin(status(5));
status_d(4) = -D/m - g*sin(status(5));
status_d(5) = L/(m*status(4)) - g* cos(status(5))/status(4);
status_d(6) = N/(m*status(4)*cos(status(5)));