function [V] = normalize_faces(V)
    for f=1:size(V,2)
        V(:,f) = (0.25*V(:,f))/median(abs(V(:,f)-median(V(:,f))));
        V(:,f) = V(:,f) - median(V(:,f)) + 0.5;
        V(find(V(:,f)>1),f) = 1;
        V(find(V(:,f)<1e-4),f) = 1e-4;
    end
end
