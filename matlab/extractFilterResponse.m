function [filter_response] = extractFilterResponse(I, filterBank)
%function [filter_response] = extractFilterResponse(I, filterBank)
%convolve each filter in the filterBank with the image and 
%concatenating all the responses into a vector for each pixel.
%Inputs:
%   I: a image of 3 channels with size M * N
%   filterBank: a cell array of filters with size F
%Outputs:
%   filter_response: a M * N * 3F matrix of filter response

double_img = double(I);
[L, a, b] = RGB2Lab(double_img(:,:,1), double_img(:,:,2), double_img(:,:,3));

unitsize = size(double_img,1) * size(double_img,2);
filter_response = zeros(unitsize, length(filterBank)*3);

for i = 0:length(filterBank)-1
    filter = filterBank{i+1};
    filter_response(:, i*3+1) = reshape(imfilter(L, filter), unitsize, 1);
    filter_response(:, i*3+2) = reshape(imfilter(a, filter), unitsize, 1);
    filter_response(:, i*3+3) = reshape(imfilter(b, filter), unitsize, 1);
end

end
    