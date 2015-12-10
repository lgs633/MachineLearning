clear all;
close all;

filename = '../data/OnlineNewsPopularity.csv';
D = csvread(filename,1,1,[1,1,39644,60]);
%[m,N] = size(D);
threshold = 20000;

Cat = cell(6,1);
C = [];

for i = 1:6
    Cat{i} = find(D(:,i+12));
    C = union(C, Cat{i});
    news1.y(Cat{i},1) = i;
end
%style, entertainment, business, socmed, tech, world

n = size(C,1);
unwanted = [1,13:18];  %which features not to consider
cols = setdiff(1:60, unwanted);  %ignoring the influence of the date

news1.X = D(C, cols);
news1.y = news1.y(C,1);
%----------------------Preparing Data--------------------------
trainInd = randsample(n,floor(n/2));
testInd = setdiff(1:n,trainInd);

Train.X = news1.X(trainInd, :);
Train.y = news1.y(trainInd, :);

Test.X = news1.X(testInd, :);
Test.y = news1.y(testInd, :);
%------------------------PCA------------------------------------
nPCA = 35;

[V, mu, ~] = PCA(Train.X);
TrainCps.X = compress(Train.X, V, mu, nPCA);
TestCps.X = compress(Test.X, V, mu, nPCA);
%---------------------------------------------------------------
nTrees = 80;

forestCat = fitensemble(TrainCps.X,Train.y,'Bag',nTrees, 'tree', 'Type', 'classification');
catPredict = predict(forestCat, TestCps.X);

for i = 1:6
    CatI =  find(Test.y(:,1)==i);
    PrecisionI = find(catPredict==i);
    score(i) = sum(catPredict(CatI,1)==Test.y(CatI,1))/length(CatI);
    precision(i) = sum(catPredict(PrecisionI,1)==Test.y(PrecisionI,1))/length(PrecisionI);
end    

test2D = TestCps.X(:,[2,3]);
test3D = TestCps.X(:,[2,4,6]);
% figure
% %scatterPlot3D(test3D,Test.y)
% scatterPlot(test2D,Test.y)
% figure
% %scatterPlot3D(test3D,catPredict)
% scatterPlot(test2D,catPredict)
score
precision

for i = 1:6
    figure
    
    subplot(1,2,2);
    scatterPlotI(test2D,catPredict,Test.y,i);
    title('True Channels');
    
    subplot(1,2,1);
    scatterPlotI(test2D,catPredict,catPredict,i); 
    
    title(['Classified as Channel ' num2str(i)]);
    savefig(['precisionFig' num2str(i) '.fig']);
end

for i = 1:6
    figure
    subplot(1,2,2);
    scatterPlotI(test2D,Test.y,catPredict,i);
    title('Classification Results');
    
    subplot(1,2,1);
    scatterPlotI(test2D,Test.y,Test.y,i) ;
    
    title(['True Channel ' num2str(i)]);
    savefig(['scoreFig' num2str(i) '.fig']);
end    

for i = 1:34
  %Cor(i) = corr(TestCps.X(:,1), Test.X(:,i));
  Cor(i) = corr(TestCps.X(:,i), Test.y);
end

fileID = fopen('scoreNprecision.txt','w');
fprintf(fileID,'%6s %12s\r\n','score','precision');
fprintf(fileID,'%6.4f %12.4f\r\n',[score',precision']);
fclose(fileID);