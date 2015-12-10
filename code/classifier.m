function [TP,TN,FP,FN,oob] = classifier(Train, Test, nTrees_vec,nPCA)
% Input: training data (train.X,train.y)
%        test data (test.X, test.y)
%        nTrees_vec (number of trees)
% Output: rate_TP,rate_TN

n_iter = length(nTrees_vec)


rate_TP = zeros(n_iter,1);
rate_FN = zeros(n_iter,1);
rate_TN = zeros(n_iter,1);
rate_FP = zeros(n_iter,1);

TP = zeros(n_iter,1);
TN = zeros(n_iter,1);
FP = zeros(n_iter,1);
FN = zeros(n_iter,1);

oob = zeros(n_iter,1);

for i = 1:n_iter
   
     nTrees=nTrees_vec(i)
    
     [V, mu, ~] = PCA(Train.X);
     Train.X = compress(Train.X, V, mu, nPCA);

     forest=fitensemble(Train.X,Train.y,'Bag',nTrees, 'tree', 'Type', 'classification');
     oob(i) = oobLoss(forest);
     disp('Training finished.');
     
     Test.X = compress(Test.X, V, mu, nPCA);
     y_pred = predict(forest, Test.X);
     disp('Testing finished.')
     tf = y_pred+2*Test.y;
     TP(i) = sum(tf==3); %truepositive
     TN(i) = sum(tf==0);
     FP(i) = sum(tf==1);
     FN(i) = sum(tf==2); %falsenegative
     
end
end

