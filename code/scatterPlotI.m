function scatterPlotI(X,y,z,i)
    color = ['r','g','b','y','k','c'];
    rows = find(y == i);
    X = X(rows,:);
    z = z(rows,:);
    for l = 1:6
        r = X(z==l,:);
        scatter(log(r(:,1)),log(r(:,2)),10,color(l)) 
        hold on
    end    
    axis equal
    axis tight
end


