function [Train, Test] = DataSelection(Data,cutpoint)
% Use median as the threshold for popular and unpopular articles
% input: Data for each category and cutpoint for training/test data

 threshold_pop = median(Data.y);
 
 N = length(Data.y);

Data.y((Data.y<threshold_pop)) = 0;
Data.y((Data.y>=threshold_pop)) = 1;

% index = 1:length(Data.y);
% rn = rand(length(Data.y),1);
% 
% index_train = index(rn>=median(rn));
% index_test = index(rn<median(rn));

 
%  Train.X =Data.X(1:cutpoint,:);
%  Train.y = Data.y(1:cutpoint,:);
% 
% Test.X = Data.X(cutpoint+1:end,:);
% Test.y = Data.y(cutpoint+1:end,:);

index_train = floor(cutpoint/2):floor(cutpoint*3/2);
Train.X =Data.X(index_train,:);
Train.y = Data.y(index_train,:);

index_test = setdiff(1:N,index_train);
Test.X = Data.X(index_test,:);
Test.y = Data.y(index_test,:);

end

