function  [status_total,t_total, te, ye, ie ] = solver_total(model,para, OriginStatus,tspan,isFigure, figure,view_input)

%这是一个通用求解器
%输入： 
%       model：要求解的微分方程模型的句柄
%       para： 模型的参数，是一个根据模型要求参数给出的向量
%       OriginStatus： 对应模型状态的初值
%       tspan： 初始时间与终止时间
%       isFigure: 是否绘图
%       figure：是否在新窗口绘图
%       view_input： 运动曲线视角
%输出：
%       status_total:总状态集合
%       t_total:对应时间集合
%       te： 落地时间
%       ye： 落地状态
%       ie：是否自然终止（落地）
%示例：
%       solver_total(@model_1,[0 0 1], [0 0 100 200 0 0],1, [0 90])
%       求解ny = 0，nz =0，m = 1， 初值为[0 0 100 200 0 0]的模型1
%       ，多次求解单独开启新窗口，运动轨迹视图视角为俯仰角90度（垂直下视）


view_angel_z = view_input(2);
view_angel_y = view_input(1);
figure_new = figure;
statusAtTheEndOfEachStep = OriginStatus;
model_input = @(t,y)model(t,y,para);

options = odeset('AbsTol',1e-9,'Events',@myEventZero);



    %求解区间
    tspan_now = linspace(tspan(1),tspan(2),10000);
    %设置ode
    [t_total, status_total,te,ye,ie] = ode45(model_input,tspan_now, statusAtTheEndOfEachStep,options);


%绘制运动轨迹
if(isFigure)
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
end
end


