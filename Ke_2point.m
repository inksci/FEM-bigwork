syms E I L;
K_e(E,I,L) =[
  (12*E*I)/L^3,  (6*E*I)/L^2, -(12*E*I)/L^3,  (6*E*I)/L^2
   (6*E*I)/L^2,    (4*E*I)/L,  -(6*E*I)/L^2,    (2*E*I)/L
 -(12*E*I)/L^3, -(6*E*I)/L^2,  (12*E*I)/L^3, -(6*E*I)/L^2
   (6*E*I)/L^2,    (2*E*I)/L,  -(6*E*I)/L^2,    (4*E*I)/L];
syms q l;
Q_e(q,l)=q*l/12*[6 l 6 -l]';
% 建立总体刚度矩阵
K_e_1(E,I,L)=[[K_e zeros(4,2)]; zeros(2,6)];
K_e_2(E,I,L)=[zeros(2,6); [zeros(4,2) K_e]];
K_total=K_e_1+K_e_2;

% 建立总载荷矩阵
Q_e_1=[2015 2015 2015 0,0 0]';
Q_e_2=[[0 0]';Q_e(-12e3,1)];
Q_total=Q_e_1+Q_e_2;
% E=200GPa;I=4e-6 m^4
K_total_this=K_total(200e9,4e-6,1);

% 划行划列法与置大数法等效
K_total_this(1,1)=9e18;
K_total_this(2,2)=9e18;
K_total_this(3,3)=9e18;
K_total_this(5,5)=9e18;

% in there,2015 is useless.if you like,you can set any number replace.
WeiYi=K_total_this^-1*Q_total;
eval(WeiYi)
