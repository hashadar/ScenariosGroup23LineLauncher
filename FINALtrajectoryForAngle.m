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
m_sp=0.1377;
m_fsp=(4/pi^2)*0.1377;
m_p=0.070;
M=m_p+m_fsp+m;
%Magnitude of Initial Velocity
Vmax=8;
Vmin=4;
Vv=linspace(Vmin,Vmax,1000);

%Angle

O=input('What is the angle in degrees you want for the trajectory');
O=(O*(pi/180));
%Matrixes
Vn=zeros(1000,1000);
x=linspace(0,0,1000);
y=linspace(0,0,1000);
V=linspace(0,0,1000);
y_d=linspace(0,0,1000);
X=zeros(1000,1000);
Y=zeros(1000,1000);

for n=1:1000
V_0=Vv(n)*sin(O);
U_0=Vv(n)*cos(O);
V=Vt.*((V_0-Vt*tan(g*t/Vt))./(Vt+V_0.*tan(g.*t./Vt)));
x=(Vt^2/g).*log((Vt^2+g*U_0.*t)./Vt^2);
y=(Vt^2/(2*g))*log((V_0.^2+Vt^2)./(V.^2+Vt^2));
Vn(n,:)=V;
X(n,:)=x;
Y(n,:)=y;

for i=1:1000
   if y(i)>=h
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
if Y(i,n)>=h
    F(i,n)=X(i,n);
else
    F(i,n)=0;
end 
    end
end
%Distance between the target and the apparatus 
d=max(F'); %#ok<UDIM>

C_eff=1; %Efficiency of the energy conservation

%The minimum k of the Spring needed
cmax=input('What is the maximum compression distance you want in metres');

k_min=(((M*((Vmax^2)+g*cmax*2*sin(O)))/(cmax^2)))/C_eff;
k_min_mm=k_min/1000;
disp('The minimum k in N/mm is')
disp(k_min_mm)
disp('The minimum k in N/m is')
disp(k_min)

%How much the Spring should be compressed for a given d
k=input('What is the k you want in N/m');

if k_min<=k 
Given_distance=input('What is the given distance');

L=linspace(0,0,1000);
for i=1:1000 
if d(i)>=Given_distance
    L(i)=d(i);
else
    L(i)=NaN;
end 
end
Lmin=min(L);
i=find(L==Lmin);

a=k;
b=-2*g*(sin(O))*(M);
f=-(M)*((Vv(i))^2);
e=sqrt((b^2)-(4*a*f));
c=(-b+e)/(2*a);
disp('The minimum compressed distance in centimetres is in metres')
disp(c*100)

else
    disp('The Spring Constant should be higher, this value cannot provide enough energy for the maximum compression value entered')
end

%Energy needed to be stored in the Spring

Ep=(((M*(0.5*(Vv(i)^2)+g*c*sin(O)))))/C_eff;

%KE at release
KE=(0.5*m*((Vv(i)^2)));