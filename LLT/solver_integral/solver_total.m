function  [status_total,t_total, te, ye, ie ] = solver_total(model,para, OriginStatus,tspan,isFigure, figure,view_input)

%����һ��ͨ�������
%���룺 
%       model��Ҫ����΢�ַ���ģ�͵ľ��
%       para�� ģ�͵Ĳ�������һ������ģ��Ҫ���������������
%       OriginStatus�� ��Ӧģ��״̬�ĳ�ֵ
%       tspan�� ��ʼʱ������ֹʱ��
%       isFigure: �Ƿ��ͼ
%       figure���Ƿ����´��ڻ�ͼ
%       view_input�� �˶������ӽ�
%�����
%       status_total:��״̬����
%       t_total:��Ӧʱ�伯��
%       te�� ���ʱ��
%       ye�� ���״̬
%       ie���Ƿ���Ȼ��ֹ����أ�
%ʾ����
%       solver_total(@model_1,[0 0 1], [0 0 100 200 0 0],1, [0 90])
%       ���ny = 0��nz =0��m = 1�� ��ֵΪ[0 0 100 200 0 0]��ģ��1
%       �������ⵥ�������´��ڣ��˶��켣��ͼ�ӽ�Ϊ������90�ȣ���ֱ���ӣ�


view_angel_z = view_input(2);
view_angel_y = view_input(1);
figure_new = figure;
statusAtTheEndOfEachStep = OriginStatus;
model_input = @(t,y)model(t,y,para);

options = odeset('AbsTol',1e-9,'Events',@myEventZero);



    %�������
    tspan_now = linspace(tspan(1),tspan(2),10000);
    %����ode
    [t_total, status_total,te,ye,ie] = ode45(model_input,tspan_now, statusAtTheEndOfEachStep,options);


%�����˶��켣
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

%���Ƴ��������ֹ�㣨������ڣ�
plot3(OriginStatus(1),OriginStatus(2),OriginStatus(3),'r+','MarkerSize',10)
hold on
if(ie==1) 
plot3(ye(1),ye(2),ye(3),'r+','MarkerSize',10)
hold on 
end

%���Ƶ�ƽ��
mx = -10000:1000:10000;
[X,Y] = meshgrid(mx);
Z = 0.*X;

mesh(X,Y,Z)
colormap winter
grid on

%�����ٶ�����
 V = status_total(:,4);
 subplot(1,2,2)
 plot(t_total,V);
 hold on
 set(gcf,'unit','normalized','position',[0.1,0.1,0.8,0.8],'name',"solver2");
end
end


