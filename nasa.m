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
V=Vt.*((V_0-Vt*tan(g*t/Vt))./(Vt+V_0.*tan(g.*t./Vt)));
x=(Vt^2/g).*log((Vt^2+g*U_0*t)./Vt^2);
y=(Vt^2/(2*g))*log((V_0^2+Vt^2)./(V.^2+Vt^2));
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
    
    Vmax=7.886
    Vmin=4.46987
