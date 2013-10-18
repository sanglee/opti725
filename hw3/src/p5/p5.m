% load data 
V = importdata('hide/face.txt');
V_test = importdata('hide/face_test.txt');

% preprocess data
V = normalize_faces(V);
V_test = normalize_faces(V_test);

% run nnmf
k = 49;
[W,H,objVals] = nnmf(V,k);

% plot first 49 faces
facesImg = compact_canvas(W);
figure, imshow(imcomplement(facesImg));
figure, plot(objVals);
title('NNMF on Training Data'); xlabel('iteration'); ylabel('objective value');

% test faces
[objVals_test,H_test] = test_faces(W,V_test);
fprintf('The test mean mean-squared-error = %g\n', objVals_test(end)/size(V_test,2));

figure, imshow(compact_canvas(V_test(:,1:49)));
V_recon = W*H_test;
figure, imshow(compact_canvas(V_recon(:,1:49)));
