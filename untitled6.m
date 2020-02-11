clc
clear
close all
g=9.81;
r=0.2;
A=pi*r^2;
Cd=0.8;
rho=1.225;
m=0.025;
V_0=5;
U_0=V_0;
Vt=sqrt((2*m*g)/(Cd*rho*A));
t=linspace(0,3);
Vx=V_0.*exp(-g.*t./Vt);
Vy=V_0.*exp(-g.*t./Vt)-Vt.*(1-exp((-g.*t)./Vt));
V=sqrt(Vy.^2+Vx.^2);
y=(Vt/g)*(V_0+Vt).*(1-exp((-g.*t)./Vt))-(Vt.*t);
x=((V_0*Vt)/g).*(1-exp((-g.*t)./Vt));
h=-0.405;
y_d=linspace(0,0);

for i=1:100
   if y(i)>h
    y_d(i)=y(i);
   else 
       y_d(i)=NaN;
   end
end
    plot(x,y_d)
hold on

V=Vt.*((V_0-Vt*tan(g*t/Vt))./(Vt+V_0.*tan(g.*t./Vt)));
x=(Vt^2/g).*log((Vt^2+g*U_0*t)./Vt^2);
y=(Vt^2/(2*g))*log((V_0^2+Vt^2)./(V.^2+Vt^2));
h=-0.405;
y_d=linspace(0,0);

for i=1:100
   if y(i)>-0.405
    y_d(i)=y(i);
   else 
       y_d(i)=NaN;
   end
end
    plot(x,y_d)
    
x=linspace(0,2);
y=x-g*x.^2/(V_0.^2);
plot(x,y);
 