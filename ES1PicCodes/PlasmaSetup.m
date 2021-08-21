function species = PlasmaSetup(p,L)
switch p
    case 1 % Equal # ions and electrons, even distribution, slight offset electrons, no initial velocities, immobile ions
        N=5;
        x=linspace(0+L/(2*N),L-L/(2*N),N);
        dx=L/20;
        
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
        electron.x0=x+dx;
        
        species=[ion electron];
        
    case 2
        
end