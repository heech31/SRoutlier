%%
clear;clc;

datetime()
cl=parcluster('local');t=tempname();mkdir(t);
cl.JobStorageLocation=t;
cpool = parpool(cl,8);



%------------------------------------------------------------------------%
d = 1000; % Dimension
n  = 100; % Sample size

propS  = 0.30; % |S| = Sprop*n
eta    = 0.30; % The number of potential outliers  

K  = 200; % The number of subspace rotations

rng(1234,'twister')

x = randn(n,d);

n_out = 10;

x(1:n_out,:) = x(1:n_out,:) + 1; % First 10 observations are location outliers

[summary, ~] = SRoutlier(x,eta,propS,K);

summary


%------------------------------------------------------------------------%
d = 1000; % Dimension
n  = 100; % Sample size

propS  = 0.30; % |S| = Sprop*n
eta    = 0.30; % The number of potential outliers  

K  = 200; % The number of subspace rotations

rng(1234,'twister')

x = randn(n,d);

n_out = 20;

x(1:n_out,:) = x(1:n_out,:) + 0.5; % First 10 observations are location outliers

[summary, ~] = SRoutlier(x,eta,propS,K);

summary


%------------------------------------------------------------------------%
d = 1000; % Dimension
n  = 100; % Sample size

propS  = 0.30; % |S| = Sprop*n
eta    = 0.30; % The number of potential outliers  

K  = 200; % The number of subspace rotations

rng(1234,'twister')

x = randn(n,d);

n_out = 10;

x(1:n_out,:) = x(1:n_out,:)*sqrt(1.5) + 0; 

[summary, ~] = SRoutlier(x,eta,propS,K);

summary











