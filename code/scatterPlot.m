function scatterPlot(X,y)
    color = ['r','g','b','y','k','c'];
    for l = 1:6
        r = X(find(y==l),:);
        scatter(r(:,1),r(:,2),color(l)) 
        hold on
    end    
    axis equal
    axis tight
end

