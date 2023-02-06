clc
close all
clear all

load data1.mat;
load data2.mat;
load data3.mat;

C = 5;

accuracy1 = validation(data1,class1,data1,C)
accuracy2 = validation(data2,class2,data2,C)
accuracy3 = validation(data3,class3,data3,C)

function accuracy_percentage = validation(traindata,trainclass,testdata,C)

%Classify data
testclass = SVM2(traindata,trainclass,traindata,C);

%Calculate accuracy
accuracy_percentage = mean(trainclass == testclass);

%Value range of data
datamin = min(traindata,[],2);
datamax = max(traindata,[],2);
dataRange = datamax-datamin;

%Produce a grid for the feature space
[X,Y] = meshgrid(datamin(1):.2:datamax(1),datamin(2):.2:datamax(2));
D = [X(:) Y(:)]';

%Train with data the classify the feature space points
d = SVM2(traindata,trainclass,D,C);

%Visualisation
figure();
d(d==-1) = 2; %Recording for plotdata colors

%Decision regions
plot(D(1,d==1),D(2,d==1),'g.',D(1,d==2),D(2,d==2),'y.');
hold on;

%Data points
plot(testdata(1,testclass==1), testdata(2,testclass==1),'bo',testdata(1,testclass==2),testdata(2,testclass==2),'ro');
hold off;
legend('Class 1','Class 2');
axis([datamin(1)-0.15*dataRange(1),datamax(1)+0.15*dataRange(1),datamin(2)-0.15*dataRange(2),datamax(2)+0.15*dataRange(2)]);
drawnow;
end