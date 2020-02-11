g=9.81;
V_0=5;
U_0=5;
Vt=26;
t=linspace(0,1.2);
V=Vt.*((V_0-Vt*tan(g*t/Vt))./(Vt+V_0.*tan(g.*t./Vt)));
x=(Vt^2/g).*log((Vt^2+g*U_0*t)./Vt^2);
y=(Vt^2/(2*g))*log((V_0^2+Vt^2)./(V.^2+Vt^2));
h=-0.405;
y_d=linspace(0,0);

for i=1:100
   if y(i)>-0.405
    y_d(i)=y(i);
   else 
       y_d=0
   end
end
    plot(x,y_d)
