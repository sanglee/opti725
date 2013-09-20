function gVec = getGradient(X,yVec,stumps,betaVec)
    for i=1:size(X,1)
        [pred_y,~] = modelEval(X(i,:),stumps,betaVec);
        gVec(i) = -2*yVec(i) / (1 + exp(2*yVec(i)*pred_y));
    end
end
