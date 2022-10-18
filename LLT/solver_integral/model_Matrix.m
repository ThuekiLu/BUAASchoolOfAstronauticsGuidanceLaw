function status_d = model_Matrix(t,status,ny,nz,m)

%这是主要考虑过载控制的仿真模型
%ny和nz表示垂直于速度方向的两个过载，为动力学模型的控制输入
%status = [x y z V gamma psi]
parameters_user_1

rou = rou_0 * exp(-status(3)/H);
D = 0.5 * rou * status(4)^2 * S_ref * C_d;
status_d = [status(4) * cos(status(5)) * sin(status(6))
            status(4) * cos(status(5)) * cos(status(6))
            status(4) * sin(status(5))
            -D/m - g*sin(status(5))
            ny
            nz];