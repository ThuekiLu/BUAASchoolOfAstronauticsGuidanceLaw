function M = Mass(t,status)

%这是主要考虑过载控制的仿真模型
%ny和nz表示垂直于速度方向的两个过载，为动力学模型的控制输入
%status = [x y z V gamma psi]

M = zeros(6,6);

M(1,1) = 1;
M(2,2) = 1;
M(3,3) = 1;
M(4,4) = 1;
M(5,5) = status(4);
M(6,6) = status(4) * cos(status(5));
end