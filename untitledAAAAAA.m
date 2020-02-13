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
for i=1:21
    Vv(:,:,i)=Vv(:,:,1);
end
%Angle
O=zeros(1,1000,21);
Q=35*(pi/180):1*(pi/180):55*(pi/180);

for i=1:1000
    O(1,i,:)=Q;
end
   
%Matrixes
Vn=zeros(1000,1000,21);
x=zeros(1,1000,21);
y=zeros(1,1000,21);
V=zeros(1,1000,21);
y_d=zeros(1,1000,21);
X=zeros(1000,1000,21);
Y=zeros(1000,1000,21);
for q=1:21 
    
for n=1:1000
V_0=Vv(1,n,q).*sin(O(1,n,q));
U_0=Vv(1,n,q).*cos(O(1,n,q));
V(1,:,q)=Vt.*((V_0-Vt*tan(g*t/Vt))./(Vt+V_0.*tan(g.*t./Vt)));
x(1,:,q)=(Vt^2/g).*log((Vt^2+g.*U_0.*t)./Vt^2);
y(1,:,q)=(Vt^2/(2*g))*log((V_0.^2+Vt^2)./((V(1,:,q)).^2+Vt^2));
Vn(n,:,q)=V(1,:,q);
X(n,:,q)=x(1,:,q);
Y(n,:,q)=y(1,:,q);

for i=1:1000
   if y(:,i,q)>=h
    y_d(:,i,q)=y(1,i,q);
   else 
       y_d(:,i,q)=NaN;
   end
end

end

%How to Find Vinital necessary for given value of d

F=zeros(1000,1000,21);
for q=1:21
for i=1:1000 
    for n=1:1000
if Y(i,n,q)>=h
    F(i,n,q)=X(i,n,q);
else
    F(i,n,q)=0;
end
    end 
end
end
%Distance between the target and the apparatus
for q=1:21
F2=permute(F,[2 1 3]);
d(1,:,q)=max(F2(:,:,q)); 
end
%Energy needed

C_eff=1; %Efficiency of the energy conservation

Ep=(0.5*m*(Vv.^2))/C_eff;


%The minimum k of the Spring needed
cmax=input('What is the maximum compression distance you want in metres');
for q=1:21
k_min=(((M*((Vmax^2)+g*cmax*2*sin(O)))/(cmax^2)))/C_eff;
k_min_mm=k_min/1000;
disp('The minimum k in N/mm is')
disp(k_min_mm(1,1,q))
disp('The minimum k in N/m is')
disp(k_min(1,1,q))
end
%How much the Spring should be compressed for a given d
k=input('What is the k you want in N/m');

if k_min<=k 
Given_distance=input('What is the given distance');

L=zeros(1,1000,21);

for i=1:1000 
    if d(1,i)>=Given_distance
    L(1,i,q)=d(1,i);
else
    L(1,i,q)=NaN;
end 
end

z