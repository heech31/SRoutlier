%% Maximal data piling distance (Ahn and Marron, 2010)


function [dmdp] = mdpdistance(x1,x2);

% calculate MDP distance
% x1 :  d by n1
% x2 :  d by n2

[n1] = size(x1,2);

[n2] = size(x2,2);

z = [x1 x2]; 

[d,n] = size(z);

z = z - repmat(mean(z,2),1,n);

ell = [ones(n1,1); -ones(n2,1)];

dmdp = 2/norm( lsqminnorm(z',ell) ) ;

