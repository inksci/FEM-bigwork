% Zhou Xin inksci@outlook.com
% CopyRight Reserved 2015
%Run Platform:Matlab R2013a
% ans =
% 
%     0.0000
%     0.0000
%    -0.1491
%    -0.5538
%    -0.5112
%    -0.8520
%    -1.4364
%    -2.6491
%    -2.9606x
%    -3.2482

function main
syms E I L;
K_e(E,I,L) =[
  (12*E*I)/L^3,  (6*E*I)/L^2, -(12*E*I)/L^3,  (6*E*I)/L^2
   (6*E*I)/L^2,    (4*E*I)/L,  -(6*E*I)/L^2,    (2*E*I)/L
 -(12*E*I)/L^3, -(6*E*I)/L^2,  (12*E*I)/L^3, -(6*E*I)/L^2
   (6*E*I)/L^2,    (2*E*I)/L,  -(6*E*I)/L^2,    (4*E*I)/L];
% 建立总体刚度矩阵
% K_e_1 2 E=200GPa L=0.5 0.5
% K_e_3 4 E=72GPa
K_e_1=[[K_e( 200e9,get_I(15e-3,3e-3),0.5 ) zeros(4,6)]; zeros(6,10)];
K_e_2=[zeros(2,10);zeros(4,2) K_e( 200e9,get_I(15e-3,3e-3),0.5 ) zeros(4,4);zeros(4,10)];
K_e_3=[zeros(4,10);zeros(4,4) K_e(72e9,get_I(10e-3,2e-3),0.5) zeros(4,2);zeros(2,10)];
K_e_4=[zeros(6,10);zeros(4,6) K_e(72e9,get_I(10e-3,2e-3),0.5)];
K_total=K_e_1+K_e_2+K_e_3+K_e_4;
K_total_this=K_total;

% 建立总载荷矩阵
Q_total=[2015 2015 0 0 -200 0 0 0 -100 0]';

% 划行划列法与置大数法等效
K_total_this(1,1)=9e18;
K_total_this(2,2)=9e18;

% in there,2015 is useless.if you like,you can set any number replace.
WeiYi=K_total_this^-1*Q_total;
WeiYi=eval(WeiYi);

% get the w(x) using insert-value-method of 3 power
syms x l;
N(x,l)=[1-3*x^2/l^2+2*x^3/l^3, x-2*x^2/l+x^3/l^2, 3*x^2/l^2-2*x^3/l^3, -x^2/l+x^3/l^2];
% How can print the formula?
w1(x)=N(x,0.5)*WeiYi(1:4,1);
theta1=diff(w1,x);
w2(x)=N(x,0.5)*WeiYi(3:6,1);
theta2=diff(w2,x);
w3(x)=N(x,0.5)*WeiYi(5:8,1);
theta3=diff(w3,x);
w4(x)=N(x,0.5)*WeiYi(7:10,1);
theta4=diff(w4,x);

% Done!
% Have a test.
% e.g.
inputX=0.5

if inputX<0.5
    w=w1(inputX);
    theta=theta1(inputX);
else if inputX<1
        w=w2(inputX-0.5);
        theta=theta2(inputX-0.5);
    else if inputX<1.5
            w=w3(inputX-1);
            theta=theta3(inputX-1);
        else if inputX<2
                w=w4(inputX-1.5);
                theta=theta4(inputX-1.5);
            end
        end
    end
end
w=eval(w)
theta=eval(theta)
end
function I=get_I(R,t)
I=(1-( (R-t)/R )^4)*pi*R^4/64;
end
