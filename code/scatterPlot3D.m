function scatterPlot3D(X,y)
    color = ['r','g','b','y','k','c'];
    for l = 1:6     %adjust the category numbers
        r = X(find(y==l),:);
        scatter3(r(:,1),r(:,2),r(:,3),color(l))
        hold on
    end    
    axis equal
    axis tight
end
