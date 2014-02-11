% Xinlei Chen
% CV Fall 2013 - Provided Code
% Modified by Supreeth Achar for CV Spring 2014
% Does computation of the filter bank and dictionary, and saves
% it in dictionary.mat
% Modified by Supreeth Achar for CV Spring 2014

load('../data/images/traintest.mat');
% give the absolute path
to_process = strcat(['../data/images/'],train_imagenames);
[filterBank,dictionary] = getFilterBankAndDictionary(to_process);
save('dictionary.mat','filterBank','dictionary');
clear to_process