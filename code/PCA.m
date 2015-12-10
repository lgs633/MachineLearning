function [V, mu, sigma2] = PCA(X, k)

D = size(X, 2);

if nargin < 2 || isempty(k) || k > D
    k = D;
end

[V, ~, sigma2, ~, ~, mu] = pca(X, 'Centered', true, 'Economy', false, ...
    'NumComponents', k);