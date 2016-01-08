function main
syms E I L;
K_e(E,I,L) =[
  (12*E*I)/L^3,  (6*E*I)/L^2, -(12*E*I)/L^3,  (6*E*I)/L^2
   (6*E*I)/L^2,    (4*E*I)/L,  -(6*E*I)/L^2,    (2*E*I)/L
 -(12*E*I)/L^3, -(6*E*I)/L^2,  (12*E*I)/L^3, -(6*E*I)/L^2
   (6*E*I)/L^2,    (2*E*I)/L,  -(6*E*I)/L^2,    (4*E*I)/L];
% E*I=10
% E*I/L^3=10/8;
K_e_this=K_e(2,5,2);

% 划行划列法与置大数法等效
K_e_this(1,1)=9e18;
K_e_this(2,2)=9e18;

% in there,2015 is useless.if you like,you can set any number replace.
WeiYi=K_e_this^-1*[2015 2015 1 0]';
eval(WeiYi)
end
