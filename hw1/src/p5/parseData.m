function [X,y,X_test,y_test] = parseData()
    tmp = importdata('./hide/digits.test');
    test5 = tmp(find(tmp(:,1)==5),2:end);
    test5y = -1*ones(1,size(test5,1));
    test6 = tmp(find(tmp(:,1)==6),2:end);
    test6y = ones(1,size(test6,1));
    X_test = [test5; test6];
    y_test = [test5y,test6y];

    train5 = importdata('./hide/digits.train.5');
    train5y = -1*ones(1,size(train5,1));
    train6 = importdata('./hide/digits.train.6');
    train6y = ones(1,size(train6,1));
    X = [train5; train6];
    y = [train5y, train6y];
    % shuffle rows
    newind = randperm(size(X,1));
    X(newind,:) = X;
    y(newind) = y;
end
