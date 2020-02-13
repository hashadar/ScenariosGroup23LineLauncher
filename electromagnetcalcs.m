%Hasha Dar
temp = input('Enter F (N), A (m^2), L (m) and I (A): ');
F = temp(1);
mu0 = 4*pi*(10^(-7));
mu = 6.3*(10^(-3));
A = temp(2);
L = temp(3);
I = temp(4);
N = sqrt((2*F*(L^2)*mu0)/((mu^2)*(I^2)*A));
disp(N)