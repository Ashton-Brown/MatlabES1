classdef Species
    % This class allows for defining the properties of a plasma species.
    % By default, it distributes the particles evenly (open ends) over the
    % given length, L, with no inital velocity.  The charge-to-mass ratio,
    % qm, and the plasma frequency, wp, are 1 by default as well.  The
    % 'move_yn' property allows for controlling whether the species is
    % mobile or stationary.
    
   properties
      qm {mustBeNumeric} = 1
      wp {mustBeNumeric} = 1
      N {mustBeNumeric} = 1
      x0 {mustBeNumeric} = 0
      vx0 {mustBeNumeric} = 0
      vy0 {mustBeNumeric} = 0
      move_yn {mustBeMember(move_yn,['y','n'])} = 'y'
   end
   methods
        function obj = Species(n,L) % Enables initializing a species with N particles, and automatically creates even distribution over L and the zero arrays for the inital velocities
            if nargin > 0
                if isnumeric([n,L])
                    dx=L/n;
                    obj.N = n;
                    obj.x0=((1:n)-0.5)*dx;
                    obj.vx0=zeros(1,n);
                    obj.vy0=zeros(1,n);
                else
                    error('Values must be numeric')
                end
            end
        end
   end
end