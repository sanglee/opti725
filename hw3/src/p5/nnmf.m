function [W,H,obj] = nnmf(V,k)
    fprintf('Starting NNMF...');
    [m,n] = size(V);
    W = rand(m,k);
    H = rand(k,n);
    for i=1:300
        M1 = W'*V; M2 = W'*W*H;
        H = H .* M1 ./ M2;
        M1 = V*H'; M2 = W*H*H';
        W = W .* M1 ./ M2;
        obj(i) = norm(V-W*H,'fro')^2;
    end
    fprintf('Finished NNMF.\n');
end
