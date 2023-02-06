function testclass = svm2(traindata, trainclass, testdata, C)
% function testclass = svm2(traindata, trainclass, testdata, C)
% 
% Non-linear support vector machine
% Type of kernel is determined by function kernel_poly2(x, y)
% which must be found in Matlab search path.

% Initialisation
X = traindata;
y = trainclass';

y(y == 2) = -1;

N = size(X, 2);
M = size(testdata,2);

% Optimisation parameters for quadprog()
H = zeros(N);
for i = 1:N
    for j = 1:N
        H(i,j) = y(i)*y(j)*Kern(X(:,i),X(:,j));
    end
end


%quadprog parameters to calculate the lambda
f = -ones(N,1);
A = [];
b = [];
Aeq = y';
beq = 0;
LB = zeros(N,1);
UB = C*ones(N,1);

% Optimisation
lambda = quadprog(H,f,A,b,Aeq,beq,LB,UB);

% Support vectors
%taking on larger lambda values
filt = (lambda(:)>1e-6);

%x vetor for those lambda values
X_k = X(:,find(filt & (y(:)==1),1)); 

% Classification
Dif = zeros(N,1);
testclass = zeros(1,M);

%Discriminant function
for i = 1:M
    for j = 1:N
        Dif(j) = lambda(j).*y(j).*Kern(X(:,j),testdata(:,i))-lambda(j).*y(j).*Kern(X(:,j),X_k);
    end
    ans = 1+sum(Dif);
    if ans>0
        testclass(i) = 1;
    else
        testclass(i) = 2;
    end
end
end
