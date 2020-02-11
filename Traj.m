V_x=5
V_y=5
V_t=(26)
t=linspace(0,5)
k=4.905/(V_t)
p_x=(1/(2*k)).*(V_x).*(1-exp(-2.*k.*t))
p_y=(1/(2*k)).*(V_y-V_t).*(1-exp(-2.*k.*t))+(V_t.*t)+0.105;
plot(p_x,p_y)