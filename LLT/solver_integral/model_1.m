function status_d = model_1(t,status)

%这是主要考虑过载控制的仿真模型
%ny和nz表示垂直于速度方向的两个过载，为动力学模型的控制输入
%status = [x y z V gamma psi]
x = status(1);
y = status(2);
z = status(3);
V = status(4);
gamma = status(5);
psi = status(6);

[ny,nz] = guidance_PN(status);


m  = 100;
parameters_user_1
status_d = zeros(6,1);
rou = rou_0 * exp(-z/H);
D = 0.5 * rou * status(4)^2 * S_ref * C_d;
status_d(1) = V * cos(gamma) * cos(psi);
status_d(2) = V * cos(gamma) * sin(psi);
status_d(3) = V * sin(gamma);
status_d(4) = -D/m - g*sin(gamma);
status_d(5) = ny/V;
status_d(6) = nz/(V * cos(gamma));
