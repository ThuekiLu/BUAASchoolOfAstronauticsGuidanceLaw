%这是求解器
%m：质量
%tspan：最大时间
%ny、nz：与速度垂直的两个方向上的过载
%step ： 最大迭代步数
%statusAtTheEndOfEachStep： 初始条件
%status = [x y z V gamma psi]

m = 100;  
tspan = 5000;

ny = 1e-15;
nz = 1;

step = 1;
statusAtTheEndOfEachStep = [0 0 300 280 0 ];
t_total = [];
status_total = [];
options = odeset('RelTol',1e-9,'NonNegative',5);
for i = 1:1:step
    tspan_now = [(i-1)*tspan/step,i*tspan/step];
    [t, status] = ode45(@(t,y)model_1_1(t,y,ny,nz,m),tspan_now, statusAtTheEndOfEachStep,options);
    statusAtTheEndOfEachStep = status(length(t),:);
    t_total = [t_total;t];
    status_total = [status_total ;status];
    i
end
%plot(t, status(:,1))
figure 
x = status_total(:,1);
y = status_total(:,2);
z = status_total(:,3);
subplot(1,2,1)
plot3(x,y,z,'r')
grid on

 V = status_total(:,4);
 subplot(1,2,2)
 plot(t_total,V);
 set(gcf,'unit','normalized','position',[0.2,0.2,0.64,0.32],'name',"solver1_1");

