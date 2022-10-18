function [ny,nz] = guidance_PN(st)

global target;
xt = target.x;
vt = target.v;

vm_abs = st(4);
gamma = st(5);
psi = st(6);

xm = st(1:3);
vm = [
    vm_abs * cos(gamma) * cos(psi),
    vm_abs * cos(gamma) * sin(psi),
    vm_abs * sin(gamma)
];

r = xt - xm;
v = vt - vm;

RTM = sqrt(r'*r);
Vc = -r'*v./RTM;
t_go = RTM./Vc;

lambda = atan(r(3)./sqrt(r(2)^2+r(1)^2));
beta = pi + atan(r(2)/r(1));

lambda_d = (v(3)*(r(2)^2+r(1)^2)-r(3)*(r(1)*v(1)+r(2)*v(2)))./(RTM^2*sqrt(r(2)^2+r(1)^2));
beta_d = (v(2)*r(1)-v(1)*r(2))./(r(2)^2+r(1)^2);

nz = 3 * Vc * beta_d * cos(lambda);
ny = 3 * sqrt(vm'*vm) * lambda_d; 
end

