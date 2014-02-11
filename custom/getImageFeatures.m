function [h] = getImageFeatures(wordMap, dictionarySize)
%function [h] = getImageFeatures(wordMap, dictionarySize)
%This function extracts the histogram of visual words within the given
%image(the bag of visual words).
%Inputs:
%   wordMap: a H * W image containg the IDs of the visual words
%   dictionarySize: the maximum visual word ID
%Outputs:
%   h: L1 normalized histogram of visual words

h = hist(wordMap(:), 1:dictionarySize);

h = h / norm(h, 1);
h = h';

end