%Matlab
%2d EM wave with absorbing boundary using pml and a square body kept in  the field
c0 = 3e8; 
epsilon=8.85e-12;
miu=1.257e-6;
dt=0.1/c0;

steps=102;
x=linspace(0,101,102);
 y=linspace(0,101,102);
T= 200;
Ez=zeros(steps,steps);
Hx=zeros(steps,steps);
Hy=zeros(steps,steps);

for m=1:steps
    for n=1:steps
        sigma(m,n)=0.009;
    end
end
%conductivity of space
for m=10:90
    for n=10:90
    sigma(m,n)=0;
    end
end
%expression for loss
for m=1:steps
    for n=1:steps
        vise(m,n)=(sigma(m,n)*dt)/(2*epsilon);
        
    end 
end
%for time steps 1 to 60
for n = 1:60
for l = 1: steps
    for m = 1:steps-1
   Hx(m,l) = ((1-vise(l,m))/(1+vise(l,m))) .*Hx(m,l)-(1/(2*c0*miu.*(1+vise(l,m)))).*(Ez(m+1,l)-Ez(m,l));%magnetic field in x direction
    end
end
for p = 1: steps
    for q= 1:steps-1
   Hy(p,q) =((1-vise(p,q))/(1+vise(p,q))) .* Hy(p,q)+(1/(2*c0*miu.*(1+vise(p,q)))).*(Ez(p,q+1)-Ez(p,q));%magnetic field in y direction
    end
end
%electric in z direction
for r = 2: steps
    for s = 2:steps
   Ez(r,s) =((1-vise(r,s))/(1+vise(r,s))) .* Ez(r,s)+(1/(2*c0*epsilon.*(1+vise(r,s)))).*(Hy(r,s)-Hy(r,s-1))-( 1/(2*c0*epsilon.*(1+vise(r,s)))).*(Hx(r,s)-Hx(r-1,s));
    end
end
Ez(88,88)=sin(((2*pi)/30)*n);%source

    
%for body in the electric field
    for m=45:55  
    for n=45:55
        Ez(m,n)=0;
    end 
    end
    
 %creating the 3d movie plot
 mesh(x,y,Ez);
   axis([0 101 0 101 -2 2]);
    getframe;
end
%for time step after 60 
for n = 61:T
for l = 1: steps
    for m = 1:steps-1
   Hx(m,l) = ((1-vise(l,m))/(1+vise(l,m))) .*Hx(m,l)-(1/(2*c0*miu.*(1+vise(l,m)))).*(Ez(m+1,l)-Ez(m,l));%magnetic field in x direction
    end
end
for p = 1: steps
    for q= 1:steps-1
   Hy(p,q) =((1-vise(p,q))/(1+vise(p,q))) .* Hy(p,q)+(1/(2*c0*miu.*(1+vise(p,q)))).*(Ez(p,q+1)-Ez(p,q));%magnetic field in y direction
    end
end
%electric field in z direction
for r = 2: steps
    for s = 2:steps
   Ez(r,s) =((1-vise(r,s))/(1+vise(r,s))) .* Ez(r,s)+(1/(2*c0*epsilon.*(1+vise(r,s)))).*(Hy(r,s)-Hy(r,s-1))-( 1/(2*c0*epsilon.*(1+vise(r,s)))).*(Hx(r,s)-Hx(r-1,s));
    end
end
Ez(88,88)=0;%source becomes 0

    
%for body in electric field
    for m=45:55 
    for n=45:55
        Ez(m,n)=0;
    end 
    end
    
 %creating 3d movie plot
 mesh(x,y,Ez);
   axis([0 101 0 101 -2 2]);
    getframe;
end
