clear
clc
close all

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

%Magnitude of Initial Velocity
Vmax=7.65;
Vmin=4.08;
Vv=linspace(Vmin,Vmax);
%Initial Velocity in one direction
Vmaxx=Vmax/sqrt(2);
Vminx=Vmin/sqrt(2);

%Initial Velocity vector in one direction
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

%How to Find Vinital necessary for given value of d

F=zeros(100);

for i=1:100 
    for n=1:100
if Y(i,n)>h
    F(i,n)=X(i,n);
else F(i,n)=0;
end 
    end
end
%Distance between the target and the apparatus
d=max(F');

%Energy needed
Ep=0.5*.025*(Vv.^2);
figure 
plot(d,Ep)

%The minimum k of the Spring needed
cmax=0.1;
k_min=0.025*((Vmax^2)/(cmax^2));
k_min_mm=k_min/1000;
disp('The minimum k in N/mm is')
disp(k_min_mm)


%How much the Spring should be compressed for a given d
k=150;
Given_distance=input('What is the given distance');

L=linspace(0,0);
for i=1:100 
if d(i)>Given_distance
    L(i)=d(i);
else L(i)=NaN;
end 
end
Lmin=min(L);
i=find(L==Lmin);
c=Vv(i).*sqrt(0.025/k);

disp('The minimum compressed distance in centimetres is')
disp(c*100)
