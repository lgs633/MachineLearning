# Learning Online News -- MachineLearning

This project is for the COMPSCI 571 class.
Hangjie Ji, Yuhao Hu, Guoshan Liu, Ma Luo

Given a piece of online news, is it possible to predict its popularity by knowing its channel, publishing time, 
its title length and the number of images or videos in it, etc? 
In aswering to this, K. Fernandes, P. Vinagre and P. Cortez [FVC14] designed a decision support system by using 
the random forest model applied to a dataset of 39797 news websites and their corresponding 61 features, which 
includes all the aspects that we mentioned above.
For our project, we propose to further the investigation, using the same dataset, based on the following two 
questions: 

(1) How does channel a↵ect popularity? How to compare a predictor trained restricting to a specific channel to one 
trained with the entire dataset? 
(2) Do channels have “styles”? In other words, is it possible to learn the channel (“Lifestyle”,“Entertainment”,
“Business”,“Social Me- dia”,“Tech”,“World”) using all the other features?
To answer the first question, we plan to apply a version of random forest model to each subset of the data that belong 
to a specific channel. Comparison will be made among trained predictors. In question two, a possible challenge is that 
all values in the data are numerical, thus one cannot infer from the keywords, which may be of valuable information, 
to which channel a piece of news belong. We would experiment with random forest, Adaboost, SVM and Naive Bayes in 
this part for better results.
References
[FVC14] K Fernandes, P Vinagre, and P Cortez, A proactive intelligent decision support system for predicting the popularity of online news, Proceedings of the 17th EPIA 2015 - Portuguese Conference on Artificial Intelligence, 2014.
