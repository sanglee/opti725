function [stumps,betaVec] = gradientBoost(X,yVec,step,numiter)

    % init the ensemble with dummy stump and beta=0
    stumps(1).j = 44; stumps(1).c = 0.4655; stumps(1).s=-1;
    betaVec = [0];

    for iter=2:numiter
        % compute gradient
        gVec = getGradient(X,yVec,stumps,betaVec);

        % find new weak learner
        s = findStump(gVec,X,iter);

        % select step size (backtracking, polynomial, or fixed)
        if step=='b'
            a = backtrack(s,stumps,betaVec,X,yVec,5); % backtracking
        elseif step=='p'
            a = 1/iter; % polynomial
        else
            a = step;  % fixed
        end

        % add new stump to ensemble
        stumps(iter) = s;

        % update beta
        betaVec(iter) = a;

        % display info
        if mod(iter,5)==0
            fprintf('Finished iter %d.\n',iter);
            accuracy = evalAllData(X,yVec,stumps,betaVec);
            fprintf('Accuracy is %g percent.\n',accuracy);
        end
    end

end
