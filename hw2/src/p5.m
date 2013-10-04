function p5(trainWs,testWs)
    Y = load(trainWs,'train');
    Yt = load(testWs,'test');

    % part a
    lams = logspace(0,3,30);
    B = zeros(size(Y));
    for i=1:length(lams)
        [Bcell{i},cntVec(i)] = mc(B,Y,lams(i));
        [accBcell{i},accCntVec(i)] = accmc(B,Y,lams(i));
        fprintf('Finished part a, lam=%g, iterCnt=%d\n',lams(i),accCntVec(i));
    end

    lam = 10;
    [~,mcObjVec] = mc2(B,Y,lam);
    [~,accmcObjVec] = accmc2(B,Y,lam);

    % part b
    rlams = fliplr(lams);
    [rBcell{1},rcntVec(1)] = mc(B,Y,rlams(1));
    [raccBcell{1},raccCntVec(1)] = accmc(B,Y,rlams(1));
    fprintf('Finished part b, lam=%g, accIterCnt=%d\n',rlams(1),raccCntVec(1));
    for i=2:length(rlams)
        [rBcell{i},rcntVec(i)] = mc(rBcell{i-1},Y,rlams(i));
        [raccBcell{i},raccCntVec(i)] = accmc(raccBcell{i-1},Y,rlams(i));
        fprintf('Finished part c, lam=%g, accIterCnt=%d\n',rlams(i),raccCntVec(i));
    end

    % part c
    mona = im2double(rgb2gray(imread('mona_bw.jpg')));
    B = zeros(size(mona));
    mona1 = subsampImg(mona,0.5);
    mona2 = subsampImg(mona,0.2);
    mlams = [1e2,2e2,5e2];
    B = zeros(size(mona));

    for i=1:length(mlams)
        [m1accBcell{i},~] = mc(B,mona1,mlams(i));
        fprintf('Finished part c (0.5 subsamp), lam=%g\n',mlams(i));
    end
    for i=1:length(mlams)
        [m2accBcell{i},~] = mc(B,mona2,mlams(i));
        fprintf('Finished part c (0.2 subsamp), lam=%g\n',mlams(i));
    end

    % plotting
    % a
    figure, plot(lams,cntVec);
    hold on; plot(lams,accCntVec,'r');
    legend('soft-impute','accelerated-soft-impute');
    xlabel('lambda'); ylabel('number of iterations');
    xlim([0,300]);
    %
    figure, plot(mcObjVec);
    hold on; plot(accmcObjVec,'r');
    legend('soft-impute','accelerated-soft-impute');
    xlabel('iteration'); ylabel('objective value');
    xlim([0,300]);
    % b
    figure, plot(rlams,rcntVec);
    hold on; plot(rlams,raccCntVec,'r');
    legend('soft-impute (warm start)','accelerated-soft-impute (warm start)');
    xlabel('lambda'); ylabel('number of iterations');
    xlim([0,300]);
    % c
    figure, imagesc(mona);
    figure, imagesc(mona1);
    figure, imagesc(mona2);
    plamsInd = [1,2,3];
    for i=1:length(plamsInd)
        figure, imagesc(m1accBcell{plamsInd(i)});
    end
    for i=1:length(plamsInd)
        figure, imagesc(m2accBcell{plamsInd(i)});
    end

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
        fprintf('mc, iter=%d, obj=%g\n',i,obj);
        if (abs(obj-lobj)/lobj) < stopping
            break;
        end
        lobj = obj;
        iterCnt = iterCnt+1;
    end
end

function [B2,iterCnt] = accmc(B1,Y,lam)
    maxIter = 500;
    stopping = 1e-4;
    lobj = 1;
    yon = find(Y>0); yno = find(Y==0);
    iterCnt = 0;
    B2 = B1;
    for i=1:maxIter
        B = B2 + ((i-2)/(i+1))*(B2 - B1);
        B1 = B2;
        Bno = B; Bno(yon) = 0;
        [B2,tnormB] = matSoftThresh(Y+Bno,lam);
        Bon = B2; Bon(yno) = 0;
        obj = (1/2)*norm(Y-Bon,'fro')^2 + lam*tnormB;
        fprintf('accmc, iter=%d, obj=%g\n',i,obj);
        if (abs(obj-lobj)/lobj) < stopping
            break;
        end
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

function [B,objVec] = subgradient(B,Y,lam)
    yno = find(Y==0);
    for i=1:500
        t = 1/i;
        Bon = B; B(yno) = 0;
        [U,S,V] = svd(B);
        subgrad = (-2*Y+Bon) + lam*U*V';
        B = B - t*subgrad;
        objVec(i) = getObj(Y,B,lam);
    end
end

function [B,objVec] = mc2(B,Y,lam)
    maxIter = 500;
    yon = find(Y>0); yno = find(Y==0);
    for i=1:maxIter
        Bno = B; Bno(yon) = 0;
        [B,tnormB] = matSoftThresh(Y+Bno,lam);
        Bon = B; Bon(yno) = 0;
        objVec(i) = (1/2)*norm(Y-Bon,'fro')^2 + lam*tnormB;
    end
end

function [B2,objVec] = accmc2(B1,Y,lam)
    maxIter = 500;
    yon = find(Y>0); yno = find(Y==0);
    iterCnt = 0;
    B2 = B1;
    for i=3:maxIter
        B = B2 + ((i-2)/(i+1))*(B2 - B1);
        B1 = B2;
        Bno = B; Bno(yon) = 0;
        [B2,tnormB] = matSoftThresh(Y+Bno,lam);
        Bon = B2; Bon(yno) = 0;
        objVec(i) = (1/2)*norm(Y-Bon,'fro')^2 + lam*tnormB;
        iterCnt = iterCnt+1;
    end
end

function obj = getObj(Y,B,lam)
    yno = find(Y==0);
    [U,S,V] = svd(B);
    tnormB = sum(diag(S));
    B(yno) = 0;
    obj = (1/2)*norm(Y-B,'fro')^2 + lam*tnormB;
end

function I = subsampImg(I,frac)
    numoffpts = (1-frac)*length(I(:));
    offpts = randperm(length(I(:)),numoffpts);
    I(offpts) = 0;
end
