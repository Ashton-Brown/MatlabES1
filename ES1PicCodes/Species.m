classdef Species
   properties
      q {mustBeNumeric} = 1
      m {mustBeNumeric} = 1
      N {mustBeNumeric} = 1
      x0 {mustBeNumeric} = 0
      vx0 {mustBeNumeric} = 0
      vy0 {mustBeNumeric} = 0
      move_yn {mustBeMember(move_yn,['y','n'])} = 'y'
   end
   methods
       function Ntot = Ntotal(obj)
           Ntot=0;
           for i=1:length(obj)
               Ntot=Ntot+obj(i).N;
           end
       end
   end
end