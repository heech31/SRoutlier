%% Screening for subspace rotated data

function [ds, order] = o_screen(rdx);

N = size(rdx,2);

oneMat = ones(N,N);

oneMat(logical(eye(N))) = -1*ones(N,1);

b = lsqminnorm( rdx' ,oneMat);

dh = 2./vecnorm(b);

[ds, order] = sort(dh);

