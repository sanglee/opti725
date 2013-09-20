[X,y,Xt,yt] = parseData();
numIter = 50;

% backtrack step-sizes
[stumps,betaVec] = gradientBoost(X,y,'b',numIter);
for i=1:numIter
    accVec_tr(i) = evalAllData(X,y,stumps(1:i),betaVec(1:i));
    accVec_te(i) = evalAllData(Xt,yt,stumps(1:i),betaVec(1:i));
end
figure, plot(100-accVec_tr,'r--');
hold on, plot(100-accVec_te);
legend('Training Error', 'Testing Error')
drawnow;

% backtrack step-sizes
[stumps,betaVec] = gradientBoost(X,y,'b',numIter);
for i=1:numIter
    accVec_tr(i) = evalAllData(X,y,stumps(1:i),betaVec(1:i));
    accVec_te(i) = evalAllData(Xt,yt,stumps(1:i),betaVec(1:i));
end
figure, plot(100-accVec_tr,'r--');
hold on, plot(100-accVec_te);
legend('Training Error', 'Testing Error')
drawnow;


% fixed step-sizes
[stumps,betaVec] = gradientBoost(X,y,0.1,numIter);
for i=1:numIter
    accVec_tr(i) = evalAllData(X,y,stumps(1:i),betaVec(1:i));
    accVec_te(i) = evalAllData(Xt,yt,stumps(1:i),betaVec(1:i));
end
figure, plot(100-accVec_tr,'r--');
hold on, plot(100-accVec_te);
legend('Training Error', 'Testing Error')
drawnow;

% fixed step-sizes
[stumps,betaVec] = gradientBoost(X,y,0.5,numIter);
for i=1:numIter
    accVec1(i) = evalAllData(Xt,yt,stumps(1:i),betaVec(1:i));
end
for i=1:numIter
    accVec_tr(i) = evalAllData(X,y,stumps(1:i),betaVec(1:i));
    accVec_te(i) = evalAllData(Xt,yt,stumps(1:i),betaVec(1:i));
end
figure, plot(100-accVec_tr,'r--');
hold on, plot(100-accVec_te);
legend('Training Error', 'Testing Error')
drawnow;
