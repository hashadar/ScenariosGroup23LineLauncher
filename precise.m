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
t=linspace(0,1.5,1000);

%Magnitude of Initial Velocity
Vmax=7.67;
Vmin=4.08;
Vv=linspace(Vmin,Vmax,1000);
%Initial Velocity in one direction
Vmaxx=Vmax/sqrt(2);
Vminx=Vmin/sqrt(2);

%Initial Velocity vector in one direction
P=linspace(Vminx,Vmaxx,1000);

%Matrixes
Vn=zeros(1000,1000);
x=linspace(0,0,1000);
y=linspace(0,0,1000);
V=linspace(0,0,1000);
y_d=linspace(0,0,1000);
X=zeros(1000,1000);
Y=zeros(1000,1000);

for n=1:1000
V_0=P(n);
U_0=V_0;
V=Vt.*((V_0-Vt*tan(g*t/Vt))./(Vt+V_0.*tan(g.*t./Vt)));
x=(Vt^2/g).*log((Vt^2+g*U_0.*t)./Vt^2);
y=(Vt^2/(2*g))*log((V_0.^2+Vt^2)./(V.^2+Vt^2));
Vn(n,:)=V;
X(n,:)=x;
Y(n,:)=y;

for i=1:1000
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

F=zeros(1000);

for i=1:1000 
    for n=1:1000
if Y(i,n)>h
    F(i,n)=X(i,n);
else
    F(i,n)=0;
end 
    end
end
%Distance between the target and the apparatus
d=max(F'); %#ok<UDIM>

%Energy needed

C_eff=1; %Efficiency of the energy conservation

Ep=(0.5*.025*(Vv.^2))/C_eff;
figure 
plot(d,Ep)
xlabel('Distance in X direction (m)')
ylabel('Energy Required to be Stored in the Spring (J)')
title('Energy vs Distance')

%The minimum k of the Spring needed
cmax=input('What is the maximum compression distance you want in metres');

k_min=(0.025*((Vmax^2)/(cmax^2)))/C_eff;
k_min_mm=k_min/1000;
disp('The minimum k in N/mm is')
disp(k_min_mm)
disp('The minimum k in N/m is')
disp(k_min)

%How much the Spring should be compressed for a given d
k=input('What is the k you want in N/m');

if k_min<k 
Given_distance=input('What is the given distance');

L=linspace(0,0,1000);
for i=1:1000 
if d(i)>Given_distance
    L(i)=d(i);
else
    L(i)=NaN;
end 
end
Lmin=min(L);
i=find(L==Lmin);
c=Vv(i).*sqrt(0.025/(k*C_eff));

disp('The minimum compressed distance in centimetres is')
disp(c*100)

else
    disp('The Spring Constant should be higher, this value cannot provide enough energy for the maximum compression value entered')
end
