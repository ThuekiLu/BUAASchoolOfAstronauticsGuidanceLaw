%这是求解器
%m：质量
%tspan：最大时间
%ny、nz：与速度垂直的两个方向上的过载
%step ： 最大迭代步数
%statusAtTheEndOfEachStep： 初始条件
%status = [x y z V gamma psi]

m = 100;  
tspan = 50;

ny = 10;
nz = 10;

step = 1;
statusAtTheEndOfEachStep = [0 0 300 280 0 0];
t_total = [];
status_total = [];
options = odeset('Mass',@(t,status)Mass(t,status));
for i = 1:1:step
    tspan_now = linspace((i-1)*tspan/step,i*tspan/step,1000);
    [t, status] = ode113(@(t,y)model_Matrix(t,y,ny,nz,m),tspan_now, statusAtTheEndOfEachStep,options);
    statusAtTheEndOfEachStep = status(length(t),:);
    t_total = [t_total;t];
    status_total = [status_total ;status];
    i
end
%plot(t, status(:,1))
x = status_total(:,1);
y = status_total(:,2);
z = status_total(:,3);
plot3(x,y,z,'k')
grid on

hold on 