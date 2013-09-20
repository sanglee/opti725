function a = backtrack(newStump,prevStumps,betaVec,X,yVec,maxiter)

    %gam1 = 0.5;
    gam1 = 0.1;
    gam2 = 0.5;
    a = 1;
    gVec = getGradient(X,yVec,prevStumps,betaVec);

    [s1,s2] = getSides();
    counter=0;
    while s1>s2
        a = gam2*a;
        [s1,s2] = getSides();
        counter = counter+1;
        if counter>maxiter, break; end
    end

    function [v1,v2] = getSides()
        v1=0; v2=0;
        for i=1:size(X,1)
            [yPred,~] = modelEval(X(i,:),prevStumps,betaVec);
            newPred = stumpEval(X(i,:),newStump);
            v1 = v1 + log(1+exp(-2*yVec(i)*(yPred+a*newPred)));
            v2 = v2 + log(1+exp(-2*yVec(i)*yPred));
        end
        v2 = v2 - gam1*a*norm(gVec)^2;
    end

end
