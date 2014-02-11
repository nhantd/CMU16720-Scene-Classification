function guessedImage = guessImage( imagename )
% Xinlei Chen
% CV Fall 2013 - Provided Code
% Modified by Supreeth Achar for CV Spring 2014
% Given a path to a scene image, guess what scene it is
% Input:
%   imagename - path to the image

load('vision.mat');
%fprintf('[Loading..]\n');
image = im2double(imread(imagename));
% imshow(image);
%fprintf('[Getting Visual Words..]\n');
wordMap = getVisualWords(image, filterBank, dictionary);
h = getImageFeaturesSPM( 3, wordMap, size(dictionary,1));
distances = distanceToSet(h, train_features);
[~,nnI] = max(distances);
load('../data/images/traintest.mat','mapping');
guessedImage = mapping{train_labels(nnI)};
fprintf('[My Guess]:%s.\n',guessedImage);

end

