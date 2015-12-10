function Y = compress( X, V, mu, k )
    [N,D] = size(X);    
    Xc = X - ones(N,1)*mu;    %Centralizing X
    if k < size(V,2)
        Y = Xc* V(:,1:k);
    else
        Y = Xc* V;
    end
end

