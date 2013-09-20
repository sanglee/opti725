function [accuracy,results] = evalAllData(X,y,stumps,betaVec)
    for i=1:size(X,1)
        results(1,i) = sign(modelEval(X(i,:),stumps,betaVec));
    end
    accuracy = (length(find(results==y)) / length(y))*100;
end
