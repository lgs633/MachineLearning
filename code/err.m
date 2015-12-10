function e = err( tau, S )
    e = 0;
    N = size(S.X,1);
    for i = 1:N
        if S.y(i)~=treeClassify(S.X(i,:), tau)
            e=e+1;
        end
    end
    e = e/N;
end

