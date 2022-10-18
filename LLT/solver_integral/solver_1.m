%这是求解器
%m：质量
%tspan：最大时间
%ny、nz：与速度垂直的两个方向上的过载
%step ： 最大迭代步数
%statusAtTheEndOfEachStep： 初始条件
%status = [x y z V gamma psi]

global target 
target.x = [6000 ;6000;0];
target.v = [0;0;0];
tspan = 1000;
step = 1;
OriginStatus = [0 0 300 280 0 0];
statusAtTheEndOfEachStep = [0 0 300 280 0 0];
t_total = [];
status_total = [];
options = odeset('Events',@myEventZero);

for i = 1:1:step
    tspan_now = [(i-1)*tspan/step:0.01:i*tspan/step];
    [t, status,te,ye,ie] = ode45(@(t,y)model_1(t,y),tspan_now, statusAtTheEndOfEachStep,options);
    statusAtTheEndOfEachStep = status(length(t),:);
    t_total = [t_total;t];
    status_total = [status_total ;status];
    i
end
%plot(t, status(:,1))
mx = -10000:1000:10000;
[X,Y] = meshgrid(mx);
Z = 0.*X;

figure 
x = status_total(:,1);
y = status_total(:,2);
z = status_total(:,3);
subplot(1,2,1)
plot3(x,y,z,'color','k')
hold on
plot3(OriginStatus(1),OriginStatus(2),OriginStatus(3),'r+','MarkerSize',10)
hold on
if(ie==1) 
plot3(ye(1),ye(2),ye(3),'r+','MarkerSize',10)
hold on 
end
plot(target.x','r+','MarkerSize',20)
hold on

mesh(X,Y,Z)
colormap winter
grid on

 V = status_total(:,4);
 subplot(1,2,2)
 plot(t_total,V);
 set(gcf,'unit','normalized','position',[0.2,0.2,0.64,0.32],'name',"solver1");
 hold on

