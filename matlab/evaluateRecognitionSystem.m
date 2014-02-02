tic 

load('../data/images/traintest.mat','test_imagenames','test_labels','mapping');
load('vision.mat');

testSize = length('test_imagenames');
classNum = 8;
C = zeros(classNum);

for k = 1:testSize
    i = test_labels(k);
    predictClass = guessImage(['../data/images/', test_imagenames{k}]);
    predictIndex = strfind(mapping, predictClass);
    
    j = find(not(cellfun('isempty', predictIndex)));
    
    C(i,j) = C(i,j) + 1;
end

rate = trace(C) / sum(C(:));

fprintf('accuracy=%d',rate);
toc