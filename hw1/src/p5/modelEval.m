function [outVal,outClass] = modelEval(xVec,stumpStructs,betaVec)
    % returns model value (continuous) and class, for an input vector x,
    % set of betas betaVec, and collection of stumps stumpStructs.
    outVal = 0;
    if sum(betaVec)>0
        for k=1:length(stumpStructs)
             outVal = outVal + betaVec(k)*stumpEval(xVec,stumpStructs(k));
        end
    end
    outClass = sign(outVal);
end
