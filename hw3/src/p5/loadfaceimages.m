facefiles = dir('./face/');
face = [];
for i=3:length(facefiles) % the first two are . and ..
  face(:, end+1) = reshape(imread(['./face/' facefiles(i).name]), [], 1);
end
figure; imshow(uint8(compact_canvas( face(:, randsample(size(face,2), 25)))));
dlmwrite('face.txt',face,' ');
