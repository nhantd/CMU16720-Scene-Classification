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
sample_img = zeros(length(image_names) * alpha, 1, 3);

for i = 1:length(image_names)
    %read each image
    img = imread(image_names{i});
    imgsize = size(img,1) * size(img,2);
    
    %randomly choose alpha pixels
    N = numel(img(:,:,1));
    index = randperm(N, alpha);
   
    Rvector = reshape(img(:,:,1), imgsize, 1);
    Gvector = reshape(img(:,:,2), imgsize, 1);
    Bvector = reshape(img(:,:,3), imgsize, 1);
    
    %get RGB values
    Rpixels = Rvector(index);
    Gpixels = Gvector(index);
    Bpixels = Bvector(index);
    
    sample_img(1+alpha*(i-1):i*alpha, 1) = Rpixels;
    sample_img(1+alpha*(i-1):i*alpha, 2) = Gpixels;
    sample_img(1+alpha*(i-1):i*alpha, 3)  = Bpixels;
    
end

%size(sample_img)
[filter_response] = extractFilterResponse(sample_img, filterBank);
%size(filter_response)
[~, dictionary] = kmeans(filter_response, K, 'EmptyAction', 'drop');

end