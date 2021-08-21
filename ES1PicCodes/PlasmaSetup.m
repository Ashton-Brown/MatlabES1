function species = PlasmaSetup(p,L)
switch p
    case 1 % Equal # ions and electrons, even distribution, alternating offset electrons, no initial velocities, immobile ions
        N=4;
        x=linspace(0+L/(2*N),L-L/(2*N),N);
        dx=L/10;
        for i=1:N
            altdx(i)=(-1)^(i)*dx;
        end
        
        ion=Species;
        ion.N=N;
        ion.q=1;
        ion.vx0=0*ones(1,N);
        ion.vy0=0*ones(1,N);
        ion.x0=x;
        ion.move_yn='n';
        
        electron=Species;
        electron.N=N;
        electron.q=-1;
        electron.vx0=0*ones(1,N);
        electron.vy0=0*ones(1,N);
        electron.x0=x+altdx;
        
        species=[ion electron];
        
    case 2 % Electrons, even distribution with same offset, no initial velocities
        N=4;
        [x,v]=init(N,L,0,0,0,0,0,0,0);
        dx=L/10;
        
        electron=Species;
        electron.N=N;
        electron.q=-1;
        electron.vx0=v;
        electron.vy0=v;
        electron.x0=x+dx;
        
        species=electron;
        
        case 3 % Electrons, even distribution with alternating offset, no initial velocities
        N=4;
        [x,v]=init(N,L,0,0,0,0,0,0,0);
        dx=L/10;
        for i=1:N
            altdx(i)=(1)^(i)*dx;
        end
        
        electron=Species;
        electron.N=N;
        electron.q=-1;
        electron.vx0=v;
        electron.vy0=v;
        electron.x0=x+altdx;
        
        species=electron;
        
    case 4 % Alternating offset electrons, no initial velocities, large number of immobile neutralizing ions
        fac=100;
        Ne=4;
        Ni=fac*Ne;
        [xe,ve]=init(Ne,L,0,0,0,0,0,0,0);
        [xi,vi]=init(Ni,L,0,0,0,0,0,0,0);
        dx=L/10;
        for i=1:Ne
            altdx(i)=(1)^(i)*dx;
        end

        ion=Species;
        ion.N=Ni;
        ion.q=1/fac;
        ion.vx0=vi;
        ion.vy0=vi;
        ion.x0=xi;
        ion.move_yn='n';

        electron=Species;
        electron.N=Ne;
        electron.q=-1;
        electron.vx0=ve;
        electron.vy0=ve;
        electron.x0=xe+altdx;

        species=[ion electron];

end
end