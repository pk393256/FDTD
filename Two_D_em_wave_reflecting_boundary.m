%2d EM wave with completely reflecting boundary
c0 = 3e8; 
epsilon=8.85e-12;
miu=1.257e-6;
steps=102;
x=linspace(0,101,102);
 y=linspace(0,101,102);
T= 300;
Ez=zeros(steps,steps);
Hx=zeros(steps,steps);
Hy=zeros(steps,steps);
for n = 1:T
for l = 1: steps
    for m = 1:steps-1
   Hx(m,l) = Hx(m,l)-(1/(2*c0*miu))*(Ez(m+1,l)-Ez(m,l));
    end
end
for p = 1: steps
    for q= 1:steps-1
   Hy(p,q) = Hy(p,q)+(1/(2*c0*miu))*(Ez(p,q+1)-Ez(p,q));
    end
end
for r = 2: steps
    for s = 2:steps
   Ez(r,s) = Ez(r,s)+(1/(2*c0*epsilon))*(Hy(r,s)-Hy(r,s-1))-( 1/(2*c0*epsilon))*(Hx(r,s)-Hx(r-1,s));
    end
end
    Ez(50,50) = exp(-5*((n-20)/20)^2);
 mesh(x,y,Ez);
   axis([0 101 0 101 -1 1]);
    getframe;
end