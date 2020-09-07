%% Initial screening using pairwise distances


function [candiInd, DH1] = oscreenPairwise(tR,eta,propS)


    [n,~] = size(tR);
    
    no  = round(n*eta);
    
    pd = pdist(tR);
    
    pd = squareform(pd);
        
    pdmd = zeros(1,n);
    
    
    for ii = 1:n
        
        pdmd(ii) = median( pd(ii,setdiff(1:n,ii) ) );
        
    end
    

    [~,ord] = sort( pdmd );

    s = round( n*propS -0.01 );

    nonind = sort( ord( 1:s ) )';

    canind = setdiff(1:n,nonind);


    S    = tR(nonind,:);

    Sc    = tR(canind,:);

    tDH = zeros(1,n-s);
    
    for jj = 1:(n-s)
        
        tDH(jj)  = mdpdistance(Sc(jj,:)',S');
   
    end
    

    [~,tord] = sort(tDH,'descend');

    candiInd = canind(tord(1:no));

    DH1    = tDH(tord(1:no));
end



