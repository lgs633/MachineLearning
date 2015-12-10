function  p = treePartition( tau, box )
    p = [];
    if not(isempty(tau.t))
        box_L = box;
        box_R = box;
        seg = box;
    
        if tau.d == 1
            box_L(2,1) = tau.t;
            box_R(1,1) = tau.t;
            seg(1,1) = tau.t;
            seg(2,1) = tau.t;
        else if tau.d == 2
                box_L(2,2) = tau.t;
                box_R(1,2) = tau.t;
                seg(1,2) = tau.t;
                seg(2,2) = tau.t;
            end
        end 
        p = cat(3,p,seg,treePartition(tau.L,box_L),treePartition(tau.R,box_R));
    end
        
end

