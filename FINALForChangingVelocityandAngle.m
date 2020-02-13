

%inputs
k=input('What is the k you want in N/m');
Given_distance=input('What is the given distance');

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

%Magnitude of Initial Velocity
Vmax=8;
Vmin=4;
Vv=linspace(Vmin,Vmax,1000);
for q=1:21
    Vv(:,:,q)=Vv(:,:,1);
end
%Angle
O=zeros(1,1000,21);
Q=35*(pi/180):1*(pi/180):55*(pi/180);
C=(35:1:55);

YENAH=zeros(1,1,21);

for q=1:21
    YENAH(:,:,q)=C(:,q);
end
C=YENAH;

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
end

for q=1:21
for i=1:1000
   if y(:,i,q)>=h
    y_d(:,i,q)=y(1,i,q);
   else 
       y_d(:,i,q)=NaN;
   end
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



k_min=445;

if k_min<=k 

L=zeros(1,1000,21);
for q=1:21
for i=1:1000 
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
for q=1:21
    a=k;
    b=-2*g*(sin(O))*(M);
    f=-(M)*((Vv(1,s(q),q)).^2);
    e=sqrt(((b(1,1,q)).^2)-(4*a*f));
    c(1,1,q)=(-(b(1,1,q))+e)./(2*a);
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