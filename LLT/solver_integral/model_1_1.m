function status_d = model_1_1(t,status,ny,nz,m)

%������Ҫ���ǹ��ؿ��Ƶķ���ģ��
%ny��nz��ʾ��ֱ���ٶȷ�����������أ�Ϊ����ѧģ�͵Ŀ�������
%status = [x y z V gamma]
%psi����ֱ�Ӵ�ԭʼ�����н�����ĵ���ƫ��,ע���ʱ�������gamma��ֵ�趨Ϊ0
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
