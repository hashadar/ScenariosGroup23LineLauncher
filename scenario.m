clc
clear
close all 
%for all values of d
%independent:x 
%dependant:V
h=0.405;
Cd=0.47;
A=pi*0.02^2;
rho=1.225;
d=(2:0.01:6);
alpha=(pi/4);
V=sqrt((-4.905*d.^2)./(((-h)-(d*tan(alpha)))*(cos(alpha))^2));
y=0.405+V*sin(alpha)*(d/(V*cos(alpha)))-4.905*(d/(V*cos(alpha)).^2);
Fd=Cd*A*rho*V.^2;  
Ep=0.5*.025*(V.^2);
plot(d,Ep)
xlabel('Distance (m)')
ylabel('Potential Energy in the spring (J)')
title('Energy vs Distance')
xmax=0.1;
V_max=max(V);
k_min=0.025*((V_max^2)/(xmax^2));
k_min_mm=k_min/1000;

k=150;
if k_min<k
    x=V.*sqrt(0.025/k);
    figure 
    plot(x,Ep)
    xlabel('Compression Distance (m)')
    ylabel('Potential Energy in the spring (J)')
    title('Energy vs Compression')
    
    figure
    plot(d,x)
    xlabel('Distance (m)')
    ylabel('Compression (m))')
    title('Compression vs Distance')
elseif k_min>k 
    disp('Cannot reach the target')
end

    
