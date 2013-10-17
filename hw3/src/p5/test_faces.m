function [obj,H] = test_faces(W,V)
    [m,n] = size(V);
    k = size(W,2);
    H = rand(k,n);
    for i=1:300
        M1 = W'*V; M2 = W'*W*H;
        H = H .* M1 ./ M2;
        obj(i) = norm(V-(W*H),'fro')^2;
    end
end
