function [wordMap] = getVisualWords(I, filterBank, dictionary)
%function [wordMap] = getVisualWords(I, filterBank, dictionary)
%map each pixel in the image to its cloest visual word in the dictionary.
%Inputs:
%   I: original image
%   filterBank: a set of filters with size F
%   dictionary: visual word dictionary with size K

%get the filter response of the image
row = size(I,1);
column = size(I,2);
imgsize = row * column;
wordMap = zeros(imgsize, 1);

[filter_response] = extractFilterResponse(I, filterBank);

%get the cloest distance in dictionary
dist = pdist2(dictionary, filter_response);
mindist = min(dist);

%get the value of dictionary
for i = 1:length(mindist)
    wordMap(i) = find(dist(:,i) == mindist(i));
end

wordMap = reshape(wordMap, row, column);

end