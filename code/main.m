%% main script


% load fisheriris
% xdata = meas(51:end,3:4);
% group = species(51:end);
% figure;
% svmStruct = svmtrain(xdata,group,'ShowPlot',true);

clear all;
close all;
filename = '../data/OnlineNewsPopularity.csv';
D = csvread(filename,1,1,[1,1,39644,60]);
[m,N] = size(D);
threshold = 20000;

D1 = find(D(:,13)); %style
D2 = find(D(:,14)); %entertainment
D3 = find(D(:,15)); %business
D4 = find(D(:,16)); %socmed
D5 = find(D(:,17)); %tech
D6 = find(D(:,18)); %world

C = union(union(union(D1,D2),union(D3,D4)),union(D5,D6));
C0 = setdiff(1:m,C);

news.X = D(C,1:59);
% news.X = D(C,1:38);
news.y = D(C,60);


% index_ypopular = find(news.y>=1400);
% index_yunpopular = find(news.y<1400);
% news.y = zeros(size(news.y));
% news.y(index_ypopular) = 1;


C1_index = find(news.X(:,13)); %style
C1.X = news.X(C1_index,:);
C1.y = news.y(C1_index);

C2_index = find(news.X(:,14)); %entertainment
C2.X = news.X(C2_index,:);
C2.y = news.y(C2_index);


C3_index = find(news.X(:,15)); %business
C3.X = news.X(C3_index,:);
C3.y = news.y(C3_index);


C4_index = find(news.X(:,16)); %socmed
C4.X = news.X(C4_index,:);
C4.y = news.y(C4_index);


C5_index = find(news.X(:,17)); %tech
C5.X = news.X(C5_index,:);
C5.y = news.y(C5_index);


C6_index = find(news.X(:,18)); %world
C6.X = news.X(C6_index,:);
C6.y = news.y(C6_index);


% cutpoint = size(C1.X,1)/2;
% [train, test] = DataSelection(C1,cutpoint);

cutpoint = size(news.X,1)/2;
[train, test] = DataSelection(news,cutpoint);


% nTrees_vec = [5,10,20,40,80,160];
nTrees_vec = [5,10,20,40];

OutOfBag = cell(1,6);
for nPCA=5:5:30
    [TP,TN,FP,FN,oob] = classifier(train, test, nTrees_vec, nPCA);
%    sprintf('npca = %d',nPCA)

    OutOfBag{nPCA/5} = oob; 

%      rate_TP = TP./(TP+FN) %recall
%      rate_TN = TN./(FP+TN) %sensitivity
% 
%      precision = TP./(TP+FP)

%     figure(1);
% 
%     plot(nTrees_vec,rate_TP,'-bo'), hold on;
%     plot(nTrees_vec,rate_TN,'-rs'), hold on;
%     plot(nTrees_vec,precision,'--p'),
%     axis([0 320 0 1]),legend('recall','sensitivity','precision');
end


