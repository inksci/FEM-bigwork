% Zhou Xin inksci@outlook.com
% CopyRight Reserved 2015
% the answer:
% ans =
% 
%     0.0000
%     0.0000
%    -0.5112
%    -0.8520
%    -2.9606
%    -3.2482
% which has pass the checking by Method of Mechanics of Materials

function main
syms E I L;
K_e(E,I,L) =[
  (12*E*I)/L^3,  (6*E*I)/L^2, -(12*E*I)/L^3,  (6*E*I)/L^2
   (6*E*I)/L^2,    (4*E*I)/L,  -(6*E*I)/L^2,    (2*E*I)/L
 -(12*E*I)/L^3, -(6*E*I)/L^2,  (12*E*I)/L^3, -(6*E*I)/L^2
   (6*E*I)/L^2,    (2*E*I)/L,  -(6*E*I)/L^2,    (4*E*I)/L];
syms q l;
Q_e(q,l)=q*l/12*[6 l 6 -l]';
% 建立总体刚度矩阵
% K_e_1 E=200GPa L=1
% Al E=72GPa L=1
get_I(15e-3,3e-3)
get_I(10e-3,2e-3)
K_e_1=[[K_e(200e9,get_I(15e-3,3e-3),1) zeros(4,2)]; zeros(2,6)];
K_e_2=[zeros(2,6); [zeros(4,2) K_e(72e9,get_I(10e-3,2e-3),1)]];
K_total=K_e_1+K_e_2
K_total_this=K_total;

% 建立总载荷矩阵
Q_total=[2015 2015 -200 0 -100 0]';

% 划行划列法与置大数法等效
K_total_this(1,1)=9e18;
K_total_this(2,2)=9e18;

% in there,2015 is useless.if you like,you can set any number replace.
WeiYi=K_total_this^-1*Q_total;
eval(WeiYi)
end
function I=get_I(R,t)
I=(1-( (R-t)/R )^4)*pi*R^4/64;
end
