clc
clear
close all 
%for all values of d
%independent:x 
%dependant:V
d=linspace(2,6);
alpha=(pi/4);
V=sqrt((-4.905*d.^2)./(((-0.105-(d*tan(alpha)))*(cos(alpha))^2)));
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
elseif k_min>k 
    disp('Cannot reach the target')
end

%yarkingey
    
