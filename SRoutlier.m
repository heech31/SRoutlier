function[test_summary, Ref_dist] = SRoutlier(x,eta,propS,K)
    

        n  = size(x,1); % Sample size
        
        no = round( eta*n ); % Number of candidate outlier        
        
        xc  = x-repmat(mean(x),n,1);

        [tu,td,tv]  = svd(xc','econ');           % New data will allow n-dimensional operation

        tu1=tu(:,1:n-1);

        tv1=tv(:,1:n-1);

        td1=td(1:n-1,1:n-1);

        tR  = tv1*td1;

        %----------------  Screening  ------------------------------------%
        [dcandi,~] = oscreenPairwise(tR,eta,propS);

        tstat  = zeros(no,1);

        X1    = tR(dcandi,:); % Candiate outliers

        X0    = tR;

        X0(dcandi,:) = [];    % Non-outliers

        
        for ii=1:no
            
            tstat(ii)  = mdpdistance(X1(ii,:)',X0');
            
        end
        
        %%% Candidate outlier and corresponding test statistics
        indx_candidate  = sortrows( [dcandi', tstat], -2 );

        
        [~,rearrange] = sort( tstat, 'descend' );
        
        X1 = X1(rearrange,:);


       %----------Sequential tests via subspace rotation  ----------------%
        Ref_dist = zeros(no,K);        
        
        Qs = zeros(n-no,n-no,K);

        parfor kk=1:K
            [uq,dq,vq] = svd( randn( n-no ) );
            Qs(:,:,kk) = uq*vq';
        end
        
        [G,~,~] = svd( eye(n-no+1) - (1/(n-no+1)).*ones(n-no+1,n-no+1)' );
        G = G(:,1:(end-1));

        j = 1;   pv_flg = 0;
        sr_pv = zeros(no,3);

        while (pv_flg < 0.05) && j<=no

        tmpx  = [ X0 ; X1(j,:)];            
        tmpxc = tmpx-repmat(mean(tmpx),n-no+1,1);

        parfor k=1:K
            rdx = tmpxc' * G * squeeze(Qs(:,:,k)) * G' ; ;
            [md,~] = o_screen(rdx);
            Ref_dist(j,k) = md(end);
        end

        sr_pv(j,:) = [mean( Ref_dist(j,:) > indx_candidate(j,2) ), indx_candidate(j,:) ];
        pv_flg = mean( Ref_dist(j,:) > indx_candidate(j,2) );
        j = j+1;
        end
        
        %------------ End of sequential test -----------------------------%

        
        stopInd = max( find( sr_pv(:,1) ~= 0 ) ) ;

        test_summary = sr_pv(1:stopInd,:);

        Ref_dist = Ref_dist(1:stopInd,:);

















