function [Bcell,cntVec,rmseVec_train,rmseVec_test,rBcell,rcntVec,subObj,mcObj] = p3(trainWs,testWs)
    %Y = load(trainWs,'train');
    %Yt = load(testWs,'test');

    %% part a
    %lams = logspace(0,3,30);
    %B = zeros(size(Y));
    %for i=1:length(lams)
        %[Bcell{i},cntVec(i)] = mc(B,Y,lams(i));
        %fprintf('Finished part a, lam=%g, iterCnt=%d\n',lams(i),cntVec(i));
    %end

    %% part b
    %for i=1:length(Bcell)
        %rmseVec_train(i) = rmse(Y,Bcell{i});
        %rmseVec_test(i) = rmse(Yt,Bcell{i});
    %end

    %% part c
    %rlams = fliplr(lams);
    %[rBcell{1},rcntVec(1)] = mc(B,Y,rlams(1));
    %fprintf('Finished part c, lam=%g, iterCnt=%d\n',rlams(1),rcntVec(1));
    %for i=2:length(rlams)
        %[rBcell{i},rcntVec(i)] = mc(rBcell{i-1},Y,rlams(i));
        %fprintf('Finished part c, lam=%g, iterCnt=%d\n',rlams(i),rcntVec(i));
    %end

    load('TEST_RUN_02');

    % part d
    slams = [1,5,10];
    B = zeros(size(Y));
    for i=1:length(slams)
        sB = subgradient(B,slams(i));
        subObj(i) = getObj(Y,sB,slams(i));
        [mcB,~] = mc(B,Y,slams(i));
        mcObj(i) = getObj(Y,mcB,slams(i));
    end

    save('TEST_RUN_03');

    %load('TEST_RUN_03');
    %% plotting
    %figure, plot(rmseVec_train);
    %hold on; plot(rmseVec_test,'r');
    %figure, plot(cntVec);
    %hold on; plot(rcntVec,'g');
    %figure, plot(subObj-min(subObj));
    %hold on; plot(mcObj-min(mcObj),'m');


end

function [B,iterCnt] = mc(B,Y,lam)
    maxIter = 500;
    stopping = 1e-4;
    lobj = 1;
    yon = find(Y>0); yno = find(Y==0);
    iterCnt = 0;
    for i=1:maxIter
        Bno = B; Bno(yon) = 0;
        [B,tnormB] = matSoftThresh(Y+Bno,lam);
        Bon = B; Bon(yno) = 0;
        obj = (1/2)*norm(Y-Bon,'fro')^2 + lam*tnormB;
        %if (abs(obj-lobj)/lobj) < stopping
            %break;
        %end
        lobj = obj;
        iterCnt = iterCnt+1;
    end
end

function [X,tnormX] = matSoftThresh(X,lam)
    [U,S,V] = svd(X);
    sd = diag(S)-lam;
    sd(find(sd<0)) = 0;
    S(eye(min(size(S)))==1) = sd;
    X = U*S*V';
    tnormX = sum(sd);
end

function err = rmse(Y,B) 
    errMat = Y-B;
    yno = find(Y==0);
    yon = find(Y~=0);
    errMat(yno) = 0;
    err = norm(errMat,'fro') / sqrt(size(yon,1));
end

function B = subgradient(B,lam)
    yno = find(Y==0);
    for i=1:500
        t = 1/i;
        Bon = B; B(yno) = 0;
        subgrad = (Y-Bon) + lam%%%%%;
        B = B - t*subgrad;
    end
end

function obj = getObj(Y,B,lam)
    yno = find(Y==0);
    B(yno) = 0;
    [U,S,V] = svd(B);
    tnormB = sum(diag(S));
    obj = (1/2)*norm(Y-B,'fro')^2 + lam*tnormB;
end
