%Hasha Dar
clc
clear
close all

d = [2:0.1:6];
alpha = pi/4;
v = sqrt((-4.905*(d.^2))./((-0.106-d.*tan(alpha)).*((cos(alpha))^2)));
Esp = 0.5.*0.025.*(v.^2);
vmax = max(v);
xmax = 0.05;
k = ((vmax/xmax)^2)*0.025;

plot(d, Esp)
xlabel('Distance from table to target (m)')
ylabel('Energy required in spring (J)')