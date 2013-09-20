function outVal = stumpEval(xVec,stumpStruct)
    % returns stump value in {+1,-1}, for a given xVec and stumpStruct
    outVal = (2*(stumpStruct.s*xVec(stumpStruct.j) >= stumpStruct.c)-1);
end
