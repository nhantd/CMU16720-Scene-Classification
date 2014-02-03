function [filterBank, dictionary] = getFilterBankAndDictionary(image_names)
%function [filterBank, dictionary] = getFilterBankAndDictionary(image_names)
%This function will first generate a set of filters and convolve with each
%image, then generate the visual words dictionary with K words by 
%applying k-means. Instead of using all of the filter response, the 
%function will use responses at alpha random pixels. Default value of alpha
%is 50 and value of K is 100.
%Inputs:
%   image_names: a cell array of strings containing the full path to an
%   image (or relative path wrt the working directory)
%Outputs:
%   filterBank: a set of filters with size F
%   dictionary: the visual words dictionary with size K

K = 200;
alpha = 100;

%create filter bank
[filterBank] = createFilterBank();
filterSize = length(filterBank)*3;
sample_img = zeros(length(image_names)*alpha, filterSize);

for i = 1:length(image_names)
    %read each image
    img = imread(image_names{i});
    
    %get filter response
    [filter_response] = extractFilterResponse(img, filterBank);
    
    %randomly choose alpha pixels
    N = numel(img(:,:,1));
    index = randperm(N, alpha)';
    
    sample_img(1+(i-1)*alpha: i*alpha,:) = filter_response(index,:);
    
end


%size(filter_response)
[~, dictionary] = kmeans(sample_img, K, 'EmptyAction', 'drop');

end