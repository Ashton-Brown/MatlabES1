function species = PlasmaSetup(p,L)
% This function is a repository of various standard plasmas/initial
% conditions, making it easy to set up a plasma in project/problem scripts.

switch p
    case 1 % Equal # ions and electrons, even distribution, alternating offset electrons, no initial velocities, immobile ions
        N=4;
        offset=L/N/4;
        altdx=zeros(1,N);
        for i=1:N
            altdx(i)=(-1)^(i)*offset;
        end
        
        % Ions
        ion=Species(N,L);
        ion.move_yn='n';
        
        % Electrons
        electron=Species(N,L);
        electron.qm=-1;
        electron.x0=electron.x0+altdx;
        
        species=[ion electron];
        
    case 2 % Electrons, even distribution with same offset, no initial velocities
        N=4;
        offset=L/N/4;
        
        % Electrons
        electron=Species(N,L);
        electron.qm=-1;
        electron.x0=electron.x0+offset;
        
        species=electron;
        
    case 3 % Electrons, even distribution with alternating offset, no initial velocities
        N=4;
        offset=L/N/4;
        altdx=zeros(1,N);
        for i=1:N
            altdx(i)=(-1)^(i)*offset;
        end
        
        % Electrons
        electron=Species(N,L);
        electron.qm=-1;
        electron.x0=electron.x0+altdx;
       
        species=electron;
        
    case 4 % Alternating offset electrons, no initial velocities, large number of immobile neutralizing ions
        fac=100;
        Ne=4;
        Ni=fac*Ne;
        offset=L/Ne/4;
        altdx=zeros(1,Ne);
        for i=1:Ne
            altdx(i)=(-1)^(i)*offset;
        end
        
        % Ions
        ion=Species(Ni,L);
        ion.N=Ni;
        ion.qm=1/fac;
        ion.move_yn='n';
        
        % Electrons
        electron=Species(Ne,L);
        electron.qm=-1;
        electron.x0=electron.x0+altdx;

        species=[ion electron];
        
    case 5 % 
        

end

end