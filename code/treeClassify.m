function y = treeClassify( x,tau )
    if isempty(tau.d)
        [t,y] = max(tau.p);
    else if x(tau.d)<=tau.t
            y = treeClassify(x,tau.L);
        else
            y = treeClassify(x,tau.R);
        end
    end
end

