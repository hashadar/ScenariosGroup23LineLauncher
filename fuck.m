clear
clc
close all

%inputs
k=700;
Given_distance=input('What is the given distance in metres');

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

C_eff=1; %Efficiency of the energy conservation

%Angle
O=zeros(1,7,1000);
C=linspace(35,55,1000);
Q=linspace(35*(pi/180),55*(pi/180),1000);
YENAH=zeros(1,1,1000);

for q=1:1000
    YENAH(:,:,q)=C(:,q);
end
C=YENAH;

for i=1:7
    O(1,i,:)=Q;
end

L=(6:12);
x=zeros(1,7,1000);

for q=1:1000
for i=1:7
    x(1,i,q)=L(i);
end
end 
%Magnitudeof Initial Velocity
x=x/100;
Vv=sqrt(((k.*x.^2)-(2*g*M.*sin(O).*x))./M);
 
%Matrixes
x=zeros(1,7,1000);
y=zeros(1,7,1000);
V=zeros(1,7,1000);
y_d=zeros(1,7,1000);
X=zeros(1000,7,1000);
Y=zeros(1000,7,1000);

for q=1:1000 
    for i=1:1000
for n=1:7
V_0=Vv(1,n,q).*sin(O(1,n,q));
U_0=Vv(1,n,q).*cos(O(1,n,q));
V(1,n,:)=Vt.*((V_0-Vt*tan(g*t/Vt))./(Vt+V_0.*tan(g.*t./Vt)));
x(1,n,:)=(Vt^2/g).*log((Vt^2+g.*U_0.*t)./Vt^2);
y(1,n,:)=(Vt^2/(2*g))*log((V_0.^2+Vt^2)./((V(1,n,q)).^2+Vt^2));
X(i,:,q)=x(1,:,q);
Y(i,:,q)=y(1,:,q);
end
    end
end
for q=1:1000
for i=1:7
   if y(:,i,q)>=h
    y_d(:,i,q)=y(1,i,q);
   else 
       y_d(:,i,q)=NaN;
   end
end
end


%How to Find Vinital necessary for given value of d

F=zeros(1000,7,1000);
d=zeros(1,1000,1000);
for q=1:1000
for i=1:1000 
    for n=1:7
if Y(i,n,q)>=h
    F(i,n,q)=X(i,n,q);
else
    F(i,n,q)=0;
end
    end 
end
end
%Distance between the target and the apparatus
for q=1:1000
F2=permute(F,[2 1 3]);
d(:,:,q)=max(F2(:,:,q)); 
end



k_min=445;

if k_min<=k 

L=zeros(1,1000,7);
for q=1:1000
for i=1:7 
    if d(1,i,q)>=Given_distance
    L(1,i,q)=d(1,i,q);
else
    L(1,i,q)=NaN;
    end 
end
end

s=zeros(1,1,21);
c=zeros(1,1,21);
for q=1:21
   [Lmin,s(1,1,q)] = min(L(:,:,q),[],'omitnan');
end

end
yeanah = horzcat(C, c*100);
YEANAH=zeros(2,21);
for q=1:21
    for g=1:2
        YEANAH(g,q)=yeanah(1,g,q);
    end
end

disp('The minimum compressed distance in centimetres is')
disp(YEANAH);

%ENERGY

Ep=zeros(1,1,21);
KE=zeros(1,1,21);

for q=1:21
%Energy needed to be stored in the Spring
Ep(1,1,q)=(((M.*(0.5.*((Vv(1,s(q),q)).^2)+g.*c(1,1,q).*sin(O(1,1,q))))))./C_eff;

%KE at release
KE(1,1,q)=(0.5.*m.*(((Vv(1,s(q),q)).^2)));
end