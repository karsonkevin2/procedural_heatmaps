function [outputArg1,outputArg2] = generateMap(sizeX,sizeY,numSegments)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
im = zeros(100,100);    

for n=1:8*4
im = im + randomLinedd(10,100,100);
end

imshow(im)
end

