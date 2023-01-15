clc; clear all; close all; 

Data=load ('t017.mat'); % loading the dataset no 1


X=Data.data(1,:);

y=Data.classes;

% sort data into classes for data 1

Xy1 = Data.data(1, y == 1);
Xy2 = Data.data(1, y == 2);
Xy3 = Data.data(1, y == 3);


% calculate priors
priory1 = length(Xy1) / length(X)
priory2 = length(Xy2) / length(X)
priory3 = length(Xy3) / length(X)


% create PDFs for y==1
X1y1 = fit_distribution(Xy1)


%create PDFs for y==2
X1y2 = fit_distribution(Xy2)


% create PDFs for y==3
X1y3 = fit_distribution(Xy3)



pred=[];

for i = 1:150
    py1 = probability(X(i), priory1, X1y1)*100;
    py2 = probability(X(i), priory1, X1y2)*100;
    py3 = probability(X(i), priory1, X1y3)*100;
    

    result=0   ; 
    if py1 > py2 && py1 > py3;
        result=1;
    elseif py2 > py1 && py2 > py3;
        result=2;
    else
        result=3;
    end

    pred(end+1)=result;
end

% accuracy testing

pred

accuracy = sum(y == pred,'all')/numel(pred)

C = confusionmat(y,pred)

confusionchart(C)


function dist = fit_distribution(data)

    dist = [mean(data) std(data)] ;
end

function  probability= probability(Xsample, prior, dist1)
    probability=  prior * pdf('Normal',Xsample, dist1(1), dist1(2));
end




