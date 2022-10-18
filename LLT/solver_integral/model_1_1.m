function status_d = model_1_1(t,status,ny,nz,m)

%这是主要考虑过载控制的仿真模型
%ny和nz表示垂直于速度方向的两个过载，为动力学模型的控制输入
%status = [x y z V gamma]
%psi代表直接从原始方程中解出来的弹道偏角,注意此时弹道倾角gamma初值设定为0
parameters_user_1
status_d = zeros(5,1);
rou = rou_0 * exp(-status(3)/H);
D = 0.5 * rou * status(4)^2 * S_ref * C_d;
psi = (log(abs(sec(status(5))+tan(status(5)))))*nz/ny;
status_d(1) = status(4) * cos(status(5)) * sin(psi);
status_d(2) = status(4) * cos(status(5)) * cos(psi);
status_d(3) = status(4) * sin(status(5));
status_d(4) = -D/m - g*sin(status(5));
status_d(5) = ny/status(4);
