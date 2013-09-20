function stump = findStump(gVec,X,iter)
    % Want to figure out which column/component (j) of X can be made most
    % similar to g when you do decision tree on it with some split c and some
    % param s
    
    % heuristic for quick/scalable approximate nearest stump search:
    % count number of g dims above and below 0 (p% below half)
    % for each col of X, classify each row/pt into "above" or "below" (p% value)
    % find col that has highest number of aligned values
    % instead of the usual greedy method, we have a slightly greedier, stochastic 
    %   approximation to the gradient
    p = length(find(gVec>0))/length(gVec); % percentage above 0
    for col=1:size(X,2)
        perc(col)=prctile(X(:,col),p*100)+randn*0.1;
        greaterInd = find(X(:,col)>=perc(col));
        lessInd = find(X(:,col)<perc(col));
        score1(col) = length(find(gVec(greaterInd)>=0)) + length(find(gVec(lessInd)<0));
        score2(col) = length(find(gVec(lessInd)>=0)) + length(find(gVec(greaterInd)<0));
        score(col) = max(score1(col),score2(col));
    end
    [~,stump.j] = max(score);
    stump.c = perc(stump.j);
    if score1(col) > score2(col)
        stump.s = 1;
    else
        stump.s = -1;
        stump.c = -stump.c;
    end
    stumpdist = norm(gVec-stumpEvalAllData(X,stump)).^2;
end
