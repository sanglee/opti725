function outVec = stumpEvalAllData(X,stumpStruct)
    % returns vector of stump values in {+1,-1}, for a given X and stumpStruct
    for i=1:size(X,1)
        outVec(i) = stumpEval(X(i,:),stumpStruct);
    end
end
