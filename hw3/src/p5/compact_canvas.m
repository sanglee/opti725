function [single_image] = compact_canvas(V)

nb_pics = size(V, 2);

graycolor = mean([min(V(:)), max(V(:))]);

nrows = ceil(sqrt(nb_pics(1)));
ncols = ceil(sqrt(nb_pics(1)));

% pad graycol in the end
V = V(:);
V(numel(V)+1 : 19*19*nrows*ncols ) = graycolor;

V = reshape(V, 19, 19, ncols, nrows);
% draw grid


single_image = graycolor * ones(21,21,nrows,ncols);
for i=1:ncols
  for j=1:nrows
    single_image(:,:,i,j) = [
      ones(1,21)*graycolor; 
      ones(19,1)*graycolor, V(:,:,i,j),  ones(19,1)*graycolor;
      ones(1,21)*graycolor ];
  end
end

single_image = permute(single_image, [1 3 2 4]);
single_image = reshape(single_image, [21*nrows, 21*ncols]);

