%这是求解器
%m：质量
%tspan：最大时间
%alpha, beta: 攻角，侧滑角
%step ： 最大迭代步数
%statusAtTheEndOfEachStep： 初始条件
%status = [x y z V gamma psi]
%figure_new:是否创建新图窗

view_angel_z = 90;
view_angel_y = 0;
figure_new = 0;
m = 100;  
tspan = 100;

alpha= 6;
beta = -3;
param = [alpha beta m];
step = 1;
OriginStatus = [0 0 300 280 0 0];
statusAtTheEndOfEachStep = [0 0 300 280 0 0];

t_total = [];
status_total = [];
%设置
options = odeset('AbsTol',1e-9,'Events',@myEventZero);

for i = 1:1:step
    %tspan_now = [(i-1)*tspan/step,i*tspan/step];
    %求解区间
    tspan_now = linspace((i-1)*tspan/step,i*tspan/step,1000);
    %设置ode
    [t, status,te,ye,ie] = ode45(@(t,y)model_2(t,y,param),tspan_now, statusAtTheEndOfEachStep,options);
    %更新初值
    statusAtTheEndOfEachStep = status(length(t),:);
    %更新轨迹记录
    t_total = [t_total;t];
    status_total = [status_total ;status];
    i
end

%绘制运动轨迹
if(figure_new)
    figure
end
x = status_total(:,1);
y = status_total(:,2);
z = status_total(:,3);
subplot(1,2,1)
plot3(x,y,z)
view(view_angel_y,view_angel_z)
hold on

%绘制出发点和终止点（如果存在）
plot3(OriginStatus(1),OriginStatus(2),OriginStatus(3),'r+','MarkerSize',10)
hold on
if(ie==1) 
plot3(ye(1),ye(2),ye(3),'r+','MarkerSize',10)
hold on 
end

%绘制地平面
mx = -10000:1000:10000;
[X,Y] = meshgrid(mx);
Z = 0.*X;

mesh(X,Y,Z)
colormap winter
grid on

%绘制速度曲线
 V = status_total(:,4);
 subplot(1,2,2)
 plot(t_total,V);
 hold on
 set(gcf,'unit','normalized','position',[0.1,0.1,0.8,0.8],'name',"solver2");