c0=3e8;
epsilon=8.85e-12;
miu=12.57e-7;
T=100;
steps=102;
dx=0.1;
dy=0.1;
dt=dx/c0;

x=linspace(0,101,102);
y=linspace(0,101,102);
Hx=zeros(steps,steps);
Hy=zeros(steps,steps);
Ez=zeros(steps,steps);
sigma=zeros(steps,steps);
for m=30:steps
    for n=30:steps
    sigma(m,n)=0.0;
    end
end
for m=1:steps
    for n=1:steps
        vise(m,n)=(sigma(m,n)*dt)/(2*epsilon);%loss for e field
        %vism(m,n)=(sigma(m,n)*dt)/(2*miu);%loss for h field
    end 
end

        
      
for t=1:T
    for m=1:steps
    for n=1:steps-1
        Hx(m, n) =Hx(m, n) - (Ez(m, n + 1) - Ez(m, n));
    end
    end
    for m=1:steps-1
       for n=1:steps

Hy(m, n) =Hy(m, n) + (Ez(m + 1, n) - Ez(m, n));
       end
    end
    Ez(
    Ez(50,5)=sin(((2*pi)/10)*t);
for m=2:steps
   for n=2:steps

Ez(m, n) = ((1-vise(m,n))/(1+vise(m,n))) .* Ez(m, n) + (Hy(m, n) - Hy(m - 1, n) -Hx(m, n) - Hx(m, n - 1));
   end
end
mesh(x,y,Ez);
axis([0 101 0 101 -1 1]);
getframe;
end