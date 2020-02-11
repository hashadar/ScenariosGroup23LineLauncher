g=9.81;
r=0.02;
A=pi*r^2;
Cd=0.47;
rho=1.225;
m=0.025;
V_0=5;
U_0=V_0;
Vt=sqrt((2*m*g)/(Cd*rho*A));
t=linspace(0,1.2);
Vx=zeros(100);
Vy=zeros(100);
V=zeros(100);
y=zeros(100);
x=zeros(100);
y_d=linspace(0,0);

for i=1:100    
Vx(i)=V_0.*exp(-g.*t./Vt);
Vy(i)=V_0.*exp(-g.*t./Vt)-Vt.*(1-exp((-g.*t)./Vt));
V(i)=sqrt(Vy.^2+Vx.^2);
y(i)=(Vt/g)*(V_0+Vt).*(1-exp((-g.*t)./Vt))-(Vt.*t);
x(i)=((V_0*Vt)/g).*(1-exp((-g.*t)./Vt));
h=-0.405;

for i=1:100
   if y(i)>h
    y_d(i)=y(i);
   else 
       y_d(i)=NaN;
   end
end
    plot(x(i),y_d(i))
end