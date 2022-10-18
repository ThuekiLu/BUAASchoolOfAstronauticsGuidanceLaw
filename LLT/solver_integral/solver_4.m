
parameters_user_3
m = 907.18;  
tspan = 2000;
load fitAOA_Ma_CdCl
[fitresult_Cl, ~]= createFit_Cl(x,y,z1);
[fitresult_Cd ,~]= createFit_Cd(x,y,Z2);
alpha= 20*pi/180 ;
sigma = 5*pi/180;
param = [alpha sigma m];
step = 1;
OriginStatus = [80132+R_0 pi pi*35/180 6700 0 0];
statusAtTheEndOfEachStep = [80132+R_0 pi pi*35/180 6700 0 0];

t_total = [];
status_total = [];
options = odeset('AbsTol',1e-17,'Events',@MyEventZero2);
for i = 1:1:step
    tspan_now = [(i-1)*tspan/step,i*tspan/step];
    [t, status,te,ye, ie] = ode45(@(t,y)model_4(t,y,param),tspan_now, statusAtTheEndOfEachStep,options);
%     [t, status] = ode45(@(t,y)model_4(t,y,param),tspan_now, statusAtTheEndOfEachStep);
    statusAtTheEndOfEachStep = status(length(t),:);
    t_total = [t_total;t];
    status_total = [status_total ;status];
    i
end
%绘制运动轨迹
%figure
r = status_total(:,1);
theta = status_total(:,2);
phi = status_total(:,3);

[x,y,z] = sph2cart(phi, theta, r);
subplot(1,2,1)
plot3(x,y,z);
hold on

%绘制出发点和终止点（如果存在）

plot3(OriginStatus(1)*cos(OriginStatus(2))*cos(OriginStatus(3)),OriginStatus(1)*cos(OriginStatus(2))*sin(OriginStatus(3)),OriginStatus(1)*sin(OriginStatus(2)),'r+','MarkerSize',10)
hold on
if(ie==1) 
plot3(ye(1),ye(2),ye(3),'r+','MarkerSize',10)
hold on 
end

%绘制地平面

[X,Y,Z] = sphere();
surf(R_0*X,R_0*Y,R_0*Z);
grid on

%绘制速度曲线
%  r = status_total(:,1);
 subplot(1,2,2)
%  plot(t_total,r,'k');
 set(gcf,'unit','normalized','position',[0.2,0.2,0.64,0.32],'name',"solver3");
 hold on;
 gamma = status_total(:,5);
 plot(t_total,gamma);