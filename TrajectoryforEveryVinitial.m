%Constants
g=9.81;
r=0.02;
A=pi*r^2;
Cd=0.47;
rho=1.225;
m=0.025;
h=-0.405;
Vt=sqrt((2*m*g)/(Cd*rho*A));
t=linspace(0,1.2);

%Magnitude of Velocity
Vmax=7.65;
Vmin=4.08;

%Velocity in one direction
Vmaxx=Vmax/sqrt(2);
Vminx=Vmin/sqrt(2);

%Velocity vector in one direction
P=linspace(Vminx,Vmaxx);

%Matrixes
Vn=zeros(100,100);
x=linspace(0,0);
y=linspace(0,0);
V=linspace(0,0);
y_d=linspace(0,0);

for n=1:100
V_0=P(n);
U_0=V_0;
V=Vt.*((V_0-Vt*tan(g*t/Vt))./(Vt+V_0.*tan(g.*t./Vt)));
x=(Vt^2/g).*log((Vt^2+g*U_0.*t)./Vt^2);
y=(Vt^2/(2*g))*log((V_0.^2+Vt^2)./(V.^2+Vt^2));
Vn(n,:)=V;
X(n,:)=x;
Y(n,:)=y;

for i=1:100
   if y(i)>h
    y_d(i)=y(i);
   else 
       y_d(i)=NaN;
   end
end
hold on
plot(x,y_d)
xlabel('Distance in X direction (m)')
ylabel('Distance in Y direction (m)')
title('Trajectory for Each Initial Velocity')
end

