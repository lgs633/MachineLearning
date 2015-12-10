function tau = trainTree(S, depth, random, dMax, sMin)

if depth == 0
    if nargin < 3 || isempty(random)
        random = false;
    end
    
    if nargin < 4 || isempty(dMax)
        dMax = Inf;
    end
    
    if nargin < 5 || isempty(sMin)
        sMin = 1;
    end
end

tau.d = [];
tau.t = [];
tau.L = [];
tau.R = [];
tau.p = [];

% Your code here
if OkToSplit(S, depth)
    [L,R,tau.d,tau.t] = findSplit(S);
    tau.L = trainTree(L, depth+1, random, dMax, sMin);
    tau.R = trainTree(R, depth+1, random, dMax, sMin);
else
    tau.p = distribution(S);
end
    
  
    function answer = OkToSplit(S, depth)
        % Your code here
        N = size(S.X,1);
        answer = N > sMin & depth < dMax ...
                & not(isequal(S.X-ones(N,1)*S.X(1,:),zeros(size(S.X))))...
                & impurity(S) > 0;
    end

    function [LOpt, ROpt, dOpt, tOpt] = findSplit(S)
        % Your code here
        delta_opt = -1;
        N = size(S.X,1);
        D = size(S.X,2);
        
        if random == false      %Whether randomize.
            range = 1:D;
        else
            range = randi(D);
        end
 
        for d = range
            thresh = thresholds(S.X(:,d));
            u_d = size(thresh,1);
            for l = 1: u_d
                LL.X = S.X(S.X(:,d)<=thresh(l),:);
                LL.y = S.y(S.X(:,d)<=thresh(l),1);
                RR.X = S.X(S.X(:,d)>thresh(l),:);
                RR.y = S.y(S.X(:,d)>thresh(l),1);
                delta = impurity(S) - size(LL.X,1)/N*impurity(LL)...
                        - size(RR.X,1)/N*impurity(RR);
                if delta>delta_opt
                    delta_opt = delta;
                    LOpt = LL;
                    ROpt = RR;
                    dOpt = d;
                    tOpt = thresh(l);
                end
            end
        end
    end


    function p = distribution(S)
        % Your code here
        k = max(S.y);
        p = zeros(k,1);
        n = 0;
        for i = 1: size(S.X,1)
            p(S.y(i)) = p(S.y(i))+1;
            n = n+1;
        end
        p = p/n;
    end

    function i = impurity(S)
        % Your code here
        p = distribution(S);
        i = 1-max(p);
    end

    function list = thresholds(x)
        % Your code here
        x = unique(x);
        list = (x(1:end-1,1)+x(2:end,1))/2;
        % This function produces a sorted list of split thresholds to try
        % given a vector x of the values in a single feature dimension
    end
end